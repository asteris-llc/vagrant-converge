module VagrantConverge
  module Provisioner
    class Guest < Vagrant.plugin("2", :provisioner)

      def initialize(machine, config)
        super

        @logger = Log4r::Logger.new("vagrant::provisioners::converge")
      end

      def provision
        install_converge
	execute_converge_command prepare_command
      end

      protected

      def install_converge
        return if !config.install

        @logger.info("Checking for Converge installation...")
        if !@machine.guest.capability?(:converge_installed)
          @machine.ui.warn(I18n.t("vagrant.provisioners.converge.cannot_detect"))
          return
        end

        if config.install && !machine.guest.capability(:converge_installed, config.version)
          @machine.guest.capability(:converge_install, config.version)
        end

        @machine.communicate.execute(
          "converge version",
          error_class: VagrantConverge::Errors::ConvergeNotFoundOnGuest,
          error_key: :converge_not_found_on_guest
        )
      end

      def execute_converge_command(command)
	ui_running_converge_command command

	result = execute_on_guest(command)
	raise VagrantConverge::Errors::ConvergeCommandFailed if result != 0
      end

      def execute_on_guest(command)
	@machine.communicate.sudo(command, error_check: false) do |type, data|
	  if [:stderr, :stdout].include?(type)
	    @machine.env.ui.info(data, new_line: false, prefix: false)
	  end
	end
      end

      def ui_running_converge_command(command)
        @machine.ui.detail I18n.t("vagrant.provisioners.converge.running")
	if verbosity_is_enabled?
	  @machine.env.ui.detail command
	end
      end

      def verbosity_is_enabled?
	config.verbose && !config.verbose.to_s.empty?
      end

      def prepare_command
	shell_command = []
	shell_command << "converge"
	shell_command << "apply"

	shell_command << "--local" if config.local
	shell_command << "--local-addr=" + config.local_addr if config.local_addr
	shell_command << "--log-level=" + config.log_level
	shell_command << "--no-token" if config.no_token
	shell_command << "--paramsJSON='" + config.params.to_json + "'" if config.params

	shell_command << "--rpc-addr='" + config.rpc_addr + "'" if config.rpc_addr
	shell_command << "--rpc-token='" + config.rpc_token + "'" if config.rpc_token

	if config.use_ssl
	  shell_command << "--use-ssl"
	  shell_command << "--ca-file='" + config.ca_file + "'" if config.ca_file
	  shell_command << "--cert-file='" + config.cert_file + "'" if config.cert_file
	  shell_command << "--key-file='" + config.key_file + "'" if config.key_file
	end

	config.hcl.each do |arg|
	  shell_command << arg
	end

	shell_command.flatten.join(' ')
      end
    end
  end
end
