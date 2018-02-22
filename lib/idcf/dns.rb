require "idcf/dns/errors"
require "idcf/dns/version"

# IDCF Cloud SDK
module Idcf
  # @author nownabe
  module Dns
    autoload :Client          , "idcf/dns/client"
    autoload :ClientExtensions, "idcf/dns/client_extensions"
    autoload :Request         , "idcf/dns/request"
    autoload :Resources       , "idcf/dns/resources"
    autoload :Response        , "idcf/dns/response"
    autoload :Validators      , "idcf/dns/validators"
  end
end
