require "vagrant"

module VagrantConverge
  class Plugin < Vagrant.plugin("2")
    name 'converge'

    description <<-DESC
    Provides support for provisioning your virtual machines with Converge.
    DESC

    config(:converge, :provisioner) do
      require_relative "config/guest"
      Config::Guest
    end

    provisioner(:converge) do
      require_relative "provisioner/guest"
      Provisioner::Guest
    end

    guest_capability(:linux, :converge_installed) do
      require_relative "cap/guest/posix/converge_installed"
      Cap::Guest::POSIX::ConvergeInstalled
    end

    guest_capability(:linux, :converge_install) do
      require_relative "cap/guest/posix/converge_install"
      Cap::Guest::POSIX::ConvergeInstall
    end


    guest_capability(:freebsd, :converge_installed) do
      require_relative "cap/guest/posix/converge_installed"
      Cap::Guest::POSIX::ConvergeInstalled
    end

    guest_capability(:freebsd, :converge_install) do
      require_relative "cap/guest/posix/converge_install"
      Cap::Guest::POSIX::ConvergeInstall
    end
  end
end
