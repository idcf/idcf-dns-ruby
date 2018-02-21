module Idcf
  module Dns
    module Validators
      # Record validator class
      class Record < Base
        RECORD_TYPES = /^(A|CNAME|AAAA|MX|TXT|SRV|NS|SOA)$/
        self.valid_attributes = {
          uuid:        { type: String },
          name:        { type: String, create: :required, update: :optional },
          type:        { type: RECORD_TYPES, create: :required, update: :optional },
          content:     { type: [String, Hash], create: :required, update: :optional },
          ttl:         { type: Integer, create: :required, update: :optional },
          weight:      { type: Integer, create: :optional, update: :optional },
          description: { type: String, create: :optional, update: :optional },
          priority:    { type: [Integer, NilClass], create: :optional },
          created_at:  { type: String },
          updated_at:  { type: String },
          healthcheck: { type: Hash, create: :optional, update: :optional },
        }
      end
    end
  end
end
