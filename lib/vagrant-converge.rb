
module VagrantConverge
  require "vagrant-converge/version"
  require 'vagrant-converge/plugin'
end

I18n.load_path << File.expand_path('../templates/locales/en.yml', File.dirname(__FILE__))
