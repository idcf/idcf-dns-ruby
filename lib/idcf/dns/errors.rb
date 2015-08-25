module Idcf
  module Dns
    Error = Class.new(StandardError)
    ApiError = Class.new(Error)
    InvalidAttributeName = Class.new(Error)
    InvalidAttributeType = Class.new(Error)
    MissingAttribute = Class.new(Error)
    UnnecessaryAttribute = Class.new(Error)
  end
end
