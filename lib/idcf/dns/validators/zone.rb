module Idcf
  module Dns
    module Validators
      # Zone validator class
      class Zone < Base
        self.valid_attributes = {
          uuid:          { type: String },
          name:          { type: String, create: :required },
          email:         { type: String, create: :required, update: :optional },
          description:   { type: String, create: :optional, update: :optional },
          default_ttl:   { type: Integer, create: :required, update: :optional },
          authenticated: { type: String },
          template_uuid: { type: String, create: :optional },
          created_at:    { type: String },
          updated_at:    { type: String },
          records:       { type: Array, reader: false },
        }
      end
    end
  end
end
