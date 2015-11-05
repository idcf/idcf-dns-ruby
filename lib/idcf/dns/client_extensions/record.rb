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
        # @example
        #   response =
        #       client.create_record(
        #           "1eeb34ef-0380-455a-bab2-6433d75ad6a4",
        #           name: "www.foobar.example.com",
        #           type: "A",
        #           content: "8.8.8.8",
        #           ttl: 3600
        #       )
        #
        #   response.uuid #=> uuid of a new record
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
        # @example
        #   response =
        #       client.delete_record(
        #           "429fcc21-9f9c-4769-8def-794290c13764",
        #           "f8ecf837-2618-4c8d-a9b0-aee9c71adaa2"
        #       )
        #
        #   response.status #=> 200
        def delete_record(zone_uuid, uuid, headers = {})
          delete!("zones/#{zone_uuid}/records/#{uuid}", {}, headers)
        end

        # Get a record.
        #
        # @param zone_uuid [String] UUID of zone
        # @param uuid [String] UUID of record
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        # @example
        #   response =
        #       client.get_record(
        #           "429fcc21-9f9c-4769-8def-794290c13764",
        #           "f8ecf837-2618-4c8d-a9b0-aee9c71adaa2"
        #       )
        #
        #   response.body #=>
        #   {"uuid"=>"a7c1ad9a-b8c2-4d27-a848-d3c488c6faa4",
        #    "name"=>"www.foobar.example.com",
        #    "type"=>"A",
        #    "content"=>"8.8.8.8",
        #    "ttl"=>3600,
        #    "created_at"=>"2015-11-04T16:14:44+09:00",
        #    "updated_at"=>nil,
        #    "priority"=>nil}
        def get_record(zone_uuid, uuid, headers = {})
          get!("zones/#{zone_uuid}/records/#{uuid}", {}, headers)
        end

        # Get list of records.
        #
        # @param zone_uuid [String] UUID of zone
        # @return [Response] HTTP response object
        # @example
        #   response =
        #       client.list_records("1eeb34ef-0380-455a-bab2-6433d75ad6a4")
        #
        #   response.body #=>
        #   [{"uuid"=>"e8866e73-c843-484f-869a-62ba8301cf72",
        #     "name"=>"foobar.example.com",
        #     "type"=>"SOA",
        #     "content"=>
        #         {"dns"=>"ns01.idcfcloud.com",
        #          "email"=>"foobar.example.com.",
        #          "serial"=>5,
        #          "refresh"=>10800,
        #          "retry"=>3600,
        #          "expire"=>604800,
        #          "ttl"=>3600},
        #     "ttl"=>3600,
        #     "created_at"=>"2015-10-30T17:41:10+09:00",
        #     "updated_at"=>"2015-11-04T16:14:44+09:00",
        #     "priority"=>nil},
        #    {"uuid"=>"fee48cb8-5aff-4fc9-9010-1033919c7e02",
        #     "name"=>"foobar.example.com",
        #     "type"=>"NS",
        #     "content"=>"ns01.idcfcloud.com",
        #     "ttl"=>3600,
        #     "created_at"=>"2015-10-30T17:41:10+09:00",
        #     "updated_at"=>nil,
        #     "priority"=>nil},
        #    {"uuid"=>"08af90fe-380b-4553-ae79-ad8630f3dfa3",
        #     "name"=>"foobar.example.com",
        #     "type"=>"NS",
        #     "content"=>"ns02.idcfcloud.com",
        #     "ttl"=>3600,
        #     "created_at"=>"2015-10-30T17:41:10+09:00",
        #     "updated_at"=>nil,
        #     "priority"=>nil},
        #    {"uuid"=>"f349b480-1cbe-4080-8fd7-b8fb8f219b3a",
        #     "name"=>"foobar.example.com",
        #     "type"=>"NS",
        #     "content"=>"ns03.idcfcloud.com",
        #     "ttl"=>3600,
        #     "created_at"=>"2015-10-30T17:41:10+09:00",
        #     "updated_at"=>nil,
        #     "priority"=>nil}]
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
        # @example
        #   response =
        #       client.update_record(
        #           "73e4847f-4167-463a-91e4-39c118eaf6d3",
        #           "7c8ec697-636d-46a5-ad8c-e7f58484a8d5",
        #           content: "210.140.158.1"
        #       )
        #
        #   response.body #=>
        #   {"uuid"=>"7c8ec697-636d-46a5-ad8c-e7f58484a8d5",
        #    "name"=>"foobar.example.com",
        #    "type"=>"A",
        #    "content"=>"210.140.158.1",
        #    "ttl"=>3600,
        #    "created_at"=>"2015-11-04T16:14:44+09:00",
        #    "updated_at"=>"2015-11-04T16:54:29+09:00",
        #    "priority"=>nil}
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
