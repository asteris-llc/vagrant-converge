# vagrant-converge

[![Gem Version](https://badge.fury.io/rb/vagrant-converge.svg)](https://badge.fury.io/rb/vagrant-converge)
[![Gem](https://img.shields.io/gem/dt/vagrant-converge.svg)](https://rubygems.org/gems/vagrant-converge)
[![Gem](https://img.shields.io/gem/dtv/vagrant-converge.svg)](https://rubygems.org/gems/vagrant-converge)

## Installation

    $ vagrant plugin install vagrant-converge

Uninstall with:

    $ vagrant plugin uninstall vagrant-converge

Update the plugin with:

    $ vagrant plugin update vagrant-converge

## Options

* `hcl` (required) - A list of files to run through Converge. Can be a single path as a string
* `ca_file` (optional) - Path to a CA certificate to trust. Requires `use_ssl`
* `cert_file` (optional) - Path to a certificate file for SSL. Requires `use_ssl`
* `key_file` (optional) - Path to a key file for SSL. Requires `use_ssl`
* `install` (optional) - Install Converge binary. Default to `true`
* `local` (optional) - Run Converge in local mode. Defaults to `true`
* `local_addr` (optional) - Address to use for local RPC connection
* `log_level` (optional) - Logging level. One of `DEBUG`, `INFO`, `WARN`, `ERROR` or `FATAL`. Default is `INFO`
* `no_token` (optional) - Don't use or generate an RPC token
* `params` (optional) - A hash of parameter/value pairs to pass to Converge
* `rpc_addr` (optional) - Address for server RPC connection. Overrides `local`
* `rpc_token` (optional) - Token to use for RPC
* `use_ssl` (optional) - Use SSL to connect
* `verbose` (optional) - Run the Converge plugin in verbose mode
* `version` (optional) - Specify the version of Converge. Default is the latest version.

## Example

    config.vm.provision :converge do |cvg|
        cfg.params = {
            "message" = "Not the default message"
        }
        cfg.hcl = [
            "https://bintray.com/chrisaubuchon/generic/download_file?file_path=test.hcl"
        ]
        cfg.install = true
    end

