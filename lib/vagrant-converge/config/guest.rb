module VagrantConverge
  module Config
    class Guest < Vagrant.plugin("2", :config)

      attr_accessor :hcl
      attr_accessor :ca_file
      attr_accessor :cert_file
      attr_accessor :install
      attr_accessor :key_file
      attr_accessor :local
      attr_accessor :local_addr
      attr_accessor :log_level
      attr_accessor :no_token
      attr_accessor :params
      attr_accessor :rpc_addr
      attr_accessor :rpc_token
      attr_accessor :use_ssl
      attr_accessor :verbose
      attr_accessor :version

      def initialize
	super

	@hcl	= UNSET_VALUE
	@ca_file	= UNSET_VALUE
	@cert_file	= UNSET_VALUE
	@install	= UNSET_VALUE
	@key_file	= UNSET_VALUE
	@local		= UNSET_VALUE
	@local_addr	= UNSET_VALUE
        @log_level	= UNSET_VALUE
	@no_token	= UNSET_VALUE
        @params		= UNSET_VALUE
	@rpc_addr	= UNSET_VALUE
	@rpc_token	= UNSET_VALUE
	@use_ssl	= UNSET_VALUE
	@verbose	= UNSET_VALUE
        @version        = UNSET_VALUE
      end

      def finalize!
        @hcl	= nil		if @hcl		== UNSET_VALUE
	@ca_file	= nil		if @ca_file		== UNSET_VALUE
	@cert_file	= nil		if @cert_file		== UNSET_VALUE
	@install	= true		if @install		== UNSET_VALUE
	@key_file	= nil		if @key_file		== UNSET_VALUE
	@local		= true		if @local		== UNSET_VALUE
	@local_addr	= nil		if @local_addr		== UNSET_VALUE
        @log_level	= "INFO"	if @log_level		== UNSET_VALUE
	@no_token	= nil		if @no_token		== UNSET_VALUE
        @params		= nil		if @params		== UNSET_VALUE
	@rpc_addr	= nil		if @rpc_addr		== UNSET_VALUE
	@rpc_token	= nil		if @rpc_token		== UNSET_VALUE
	@use_ssl	= false		if @use_ssl		== UNSET_VALUE
	@verbose	= false		if @verbose		== UNSET_VALUE
        @version	= :latest	if @version		== UNSET_VALUE

	# RPC connection takes precedence over local
	if @rpc_addr
	  @local = false
	  @local_addr = nil
	end
      end

      def validate(machine)
	@errors = _detected_errors

	# Validate hcl values
	if !hcl
	  @errors << I18n.t("vagrant.provisioners.converge.no_hcl")
        end

	if hcl
	  hcl_is_valid = hcl.kind_of?(Array) || hcl.kind_of?(String)

	  if hcl.kind_of?(String)
	    @hcl = [ hcl ]
	  end

	  if !hcl_is_valid
	    @errors << I18n.t("vagrant.provisioners.converge.invalid_hcl",
		type:  hcl.class.to_s,
		value: hcl.to_s)
	  end
        end

	# Validate params if provided
	if params
	  if !params.kind_of?(Hash)
	    @errors << I18n.t("vagrant.provisioners.converge.invalid_params",
		type:  params.class.to_s,
		value: params.to_s)
	  end
	end

	{ "vagrant-converge" => @errors }
      end
    end
  end
end
