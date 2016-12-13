require_relative "../../../errors"

module VagrantConverge
  module Cap
    module Guest
      module POSIX
        module ConvergeInstall
          def self.converge_install(machine, version)
	    url="https://dl.bintray.com/chrisaubuchon/converge/install.sh"
	    command = "curl -sL #{url} | sh -s --"

	    if version != :latest
		command << " -v \"#{version}\""
	    end
	    machine.communicate.sudo(command)
          end
        end
      end
    end
  end
end
