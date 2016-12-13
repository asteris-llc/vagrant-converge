module VagrantConverge
  module Cap
    module Guest
      module POSIX
        module ConvergeInstalled
          def self.converge_installed(machine, version)
            command = 'text -x "$(command -v converge)"'

            if version != :latest
              command << "&& converge version | grep 'converge #{version}'"
            end

            machine.communicate.test command, sudo: false
          end
        end
      end
    end
  end
end
