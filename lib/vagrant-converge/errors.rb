module VagrantConverge
  module Errors
    class ConvergeError < Vagrant::Errors::VagrantError
      error_namespace("vagrant.provisioners.converge.errors")
    end

    class ConvergePipInstallIsNotSupported < ConvergeError
      error_key(:cannot_support_pip_install)
    end

    class ConvergeNotFoundOnGuest < ConvergeError
      error_key(:converge_not_found_on_guest)
    end

    class ConvergeCommandFailed < ConvergeError
      error_key(:converge_command_failed)
    end
  end
end
