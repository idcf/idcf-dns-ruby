module Idcf
  module Dns
    module ClientExtensions
      # SDK APIs for zone resource
      module Zone
        # Create a new zone.
        #
        # @param attributes [Hash] request attributes
        # @option attributes [String] :name unique name of zone (required)
        # @option attributes [String] :email e-mail address (required)
        # @option attributes [String] :description description
        # @option attributes [Integer] :default_ttl default TTL (required)
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def create_zone(attributes, headers = {})
          Validators::Zone.validate_attributes!(attributes, :create)
          post!("zones", attributes, headers)
        end

        # Delete a zone.
        #
        # @param uuid [String] UUID of target zone
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def delete_zone(uuid, headers = {})
          delete!("zones/#{uuid}", {}, headers)
        end

        # Get a zone.
        #
        # @param uuid [String] UUID of target zone
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def get_zone(uuid, headers = {})
          get!("zones/#{uuid}", {}, headers)
        end

        # Get list of existing zones
        #
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def list_zones(headers = {})
          get!("zones", {}, headers)
        end

        # Update a zone.
        #
        # @param uuid [String] UUID of target zone
        # @param attributes [Hash] request attributes
        # @option attributes [String] :email e-mail address
        # @option attributes [String] :description description
        # @option attributes [Integer] :default_ttl default TTL
        # @return [Response] HTTP response object
        def update_zone(uuid, attributes, headers = {})
          Validators::Zone.validate_attributes!(attributes, :update)
          put!("zones/#{uuid}", attributes, headers)
        end

        # Get a zone object.
        #
        # @param uuid [String] UUID of target zone
        # @param headers [Hash] HTTP request headers
        # @return [Resources::Zone] a zone object
        def zone(uuid, headers = {})
          Resources::Zone.new(self, get_zone(uuid, headers).body)
        end

        # Get an array of existing zone objects.
        #
        # @param headers [Hash] HTTP request headers
        # @return [Array<Resources::Zone>] An array of zone objects
        def zones(headers = {})
          list_zones(headers).resources.map do |zone|
            Resources::Zone.new(self, zone)
          end
        end
      end
    end
  end
end
