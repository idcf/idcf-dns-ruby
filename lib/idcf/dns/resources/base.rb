require "active_support/core_ext/string/inflections"

module Idcf
  module Dns
    module Resources
      # Base resource class
      class Base
        attr_reader :client

        class << self
          # @private
          def inherited(subclass)
            subclass.send(:generate_readers)
          end

          # @private
          def class_name
            to_s.gsub(/^#<Class|>$/, "").split(/::/).last
          end

          # @private
          def generate_readers
            validator_class.valid_attributes.each do |name, properties|
              next if properties[:reader] == false
              attr_reader name
            end
          end

          # @private
          def validator_class
            "Idcf::Dns::Validators::#{class_name}".constantize
          end
        end

        # Constructor
        #
        # @param client [Client] client object
        # @param attributes [Hash] attributes for resource
        def initialize(client, attributes = {})
          @client = client
          self.attributes = attributes
        end

        # Inspect this class
        def inspect
          "#<#{self.class}:0x%014x @name=#{name} @uuid=#{uuid}>" % [object_id]
        end

        private

        def attributes=(attributes)
          self.class.validator_class.validate_attributes!(attributes)
          attributes.each do |name, value|
            instance_variable_set(:"@#{name}", value)
          end
        end
      end
    end
  end
end
