module Idcf
  module Dns
    module Validators
      # Template validator class
      class Template < Base
        self.valid_attributes = {
          uuid:        { type: String },
          name:        { type: String, create: :required },
          description: { type: String, create: :optional, update: :optional },
          default_ttl: { type: Integer, create: :required, update: :optional },
          created_at:  { type: String },
          updated_at:  { type: String },
          records:     { type: Array, reader: false }
        }
      end
    end
  end
end
