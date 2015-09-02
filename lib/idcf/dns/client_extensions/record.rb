module Idcf
  module Dns
    module ClientExtensions
      # SDK APIs for record resource
      module Record
        # Create a new record.
        #
        # @param zone_uuid [String] UUID of zone
        # @param attributes [Hash] request attributes
        # @option attributes [String] :name name of record
        # @option attributes [String] :type type of record
        #   (A, AAAA, CNAME, MX, TXT or SRV)
        # @option attributes [String] :content content of record
        # @option attributes [Integer] :ttl TTL
        # @option attributes [Integer] :priority priority of record
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def create_record(zone_uuid, attributes, headers = {})
          Validators::Record.validate_attributes!(attributes, :create)
          post!("zones/#{zone_uuid}/records", attributes, headers)
        end

        # Delete a record.
        #
        # @param zone_uuid [String] UUID of zone
        # @param uuid [String] UUID of record
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def delete_record(zone_uuid, uuid, headers = {})
          delete!("zones/#{zone_uuid}/records/#{uuid}", {}, headers)
        end

        # Get a record.
        #
        # @param zone_uuid [String] UUID of zone
        # @param uuid [String] UUID of record
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def get_record(zone_uuid, uuid, headers = {})
          get!("zones/#{zone_uuid}/records/#{uuid}", {}, headers)
        end

        # Get list of records.
        #
        # @param zone_uuid [String] UUID of zone
        # @return [Response] HTTP response object
        def list_records(zone_uuid, headers = {})
          get!("zones/#{zone_uuid}/records", {}, headers)
        end

        # Update a record.
        #
        # @param zone_uuid [String] UUID of zone
        # @param uuid [String] UUID of record
        # @param attributes [Hash] request attributes
        # @option attributes [String] :name name of record
        # @option attributes [String] :type type of record
        #   (A, AAAA, CNAME, MX, TXT or SRV)
        # @option attributes [String] :content content of record
        # @option attributes [Integer] :ttl TTL
        # @option attributes [Integer] :priority priority of record
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def update_record(zone_uuid, uuid, attributes, headers = {})
          Validators::Record.validate_attributes!(attributes, :update)
          put!("zones/#{zone_uuid}/records/#{uuid}", attributes, headers)
        end

        # Get a record object.
        #
        # @param zone_uuid [String] UUID of zone
        # @param uuid [String] UUID of record
        # @param headers [Hash] HTTP request headers
        # @return [Resources::Record] a record object
        def record(zone_uuid, uuid, headers = {})
          Resources::Record.new(self, get_record(uuid, zone_uuid, headers).body)
        end

        # Get an array of existing record objects.
        #
        # @param zone_uuid [String] UUID of zone
        # @param headers [Hash] HTTP request headers
        # @return [Array<Resource::Record>] an array of record objects
        def records(zone_uuid, headers = {})
          zone(zone_uuid).records
        end
      end
    end
  end
end
