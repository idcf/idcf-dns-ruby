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
        #     client.create_record(
        #       "ddcd8dbf-8d99-4f49-9958-7dd9a0bfb67f",
        #       name: "www.foobar.example.com",
        #       type: "A",
        #       content: "8.8.8.8",
        #       ttl: 3600
        #     )
        #
        #   response.body #=>
        #     {"uuid"=>"40d5f26f-02bd-4fb1-b363-323675772289",
        #      "name"=>"www.foobar.example.com",
        #      "type"=>"A",
        #      "content"=>"8.8.8.8",
        #      "ttl"=>3600,
        #      "created_at"=>"2015-11-09T11:43:50+09:00",
        #      "updated_at"=>nil,
        #      "priority"=>nil}
        #
        #   response.uuid #=> "40d5f26f-02bd-4fb1-b363-323675772289"
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
        #     client.delete_record(
        #       "ddcd8dbf-8d99-4f49-9958-7dd9a0bfb67f",
        #       "d612aabb-3fea-471a-8712-586f1ac9c29c"
        #     )
        #
        #   response.body #=> {}
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
        #     client.get_record(
        #       "ddcd8dbf-8d99-4f49-9958-7dd9a0bfb67f",
        #       "d612aabb-3fea-471a-8712-586f1ac9c29c"
        #     )
        #
        #   response.body #=>
        #     {"uuid"=>"ecacc77f-e678-4f29-b6dd-6bec79c172a1",
        #      "name"=>"www.foobar.example.com",
        #      "type"=>"A",
        #      "content"=>"8.8.8.8",
        #      "ttl"=>3600,
        #      "created_at"=>"2015-11-09T16:07:21+09:00",
        #      "updated_at"=>nil,
        #      "priority"=>nil}
        def get_record(zone_uuid, uuid, headers = {})
          get!("zones/#{zone_uuid}/records/#{uuid}", {}, headers)
        end

        # Get list of records.
        #
        # @param zone_uuid [String] UUID of zone
        # @return [Response] HTTP response object
        # @example
        #   response =
        #     client.list_records("ddcd8dbf-8d99-4f49-9958-7dd9a0bfb67f")
        #
        #   response.body #=>
        #     [{"uuid"=>"9fae4a12-319c-4afc-ac33-4542ef79dd0b",
        #       "name"=>"foobar.example.com",
        #       "type"=>"SOA",
        #       "content"=>
        #        {"dns"=>"ns01.idcfcloud.com",
        #         "email"=>"foobar.example.com.",
        #         "serial"=>4,
        #         "refresh"=>10800,
        #         "retry"=>3600,
        #         "expire"=>604800,
        #         "ttl"=>3600},
        #       "ttl"=>3600,
        #       "created_at"=>"2015-11-09T13:24:58+09:00",
        #       "updated_at"=>"2015-11-09T16:07:21+09:00",
        #       "priority"=>nil},
        #      {"uuid"=>"f61a75b7-8e9c-4e69-a91a-6e6aa90c2990",
        #       "name"=>"foobar.example.com",
        #       "type"=>"NS",
        #       "content"=>"ns01.idcfcloud.com",
        #       "ttl"=>3600,
        #       "created_at"=>"2015-11-09T13:24:58+09:00",
        #       "updated_at"=>nil,
        #       "priority"=>nil},
        #      {"uuid"=>"0195fe5d-7cff-4f94-8886-a13bb0f609b4",
        #       "name"=>"foobar.example.com",
        #       "type"=>"NS",
        #       "content"=>"ns02.idcfcloud.com",
        #       "ttl"=>3600,
        #       "created_at"=>"2015-11-09T13:24:58+09:00",
        #       "updated_at"=>nil,
        #       "priority"=>nil},
        #      {"uuid"=>"0bdc7d49-b1aa-4455-903f-35dc3c4338be",
        #       "name"=>"foobar.example.com",
        #       "type"=>"NS",
        #       "content"=>"ns03.idcfcloud.com",
        #       "ttl"=>3600,
        #       "created_at"=>"2015-11-09T13:24:58+09:00",
        #       "updated_at"=>nil,
        #       "priority"=>nil},
        #      {"uuid"=>"ecacc77f-e678-4f29-b6dd-6bec79c172a1",
        #       "name"=>"www.foobar.example.com",
        #       "type"=>"A",
        #       "content"=>"8.8.8.8",
        #       "ttl"=>3600,
        #       "created_at"=>"2015-11-09T16:07:21+09:00",
        #       "updated_at"=>nil,
        #       "priority"=>nil}]
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
        #     client.update_record(
        #       "ddcd8dbf-8d99-4f49-9958-7dd9a0bfb67f",
        #       "d612aabb-3fea-471a-8712-586f1ac9c29c",
        #       content: "6.6.6.6"
        #     )
        #
        #   response.body #=>
        #     {"uuid"=>"ecacc77f-e678-4f29-b6dd-6bec79c172a1",
        #      "name"=>"www.foobar.example.com",
        #      "type"=>"A",
        #      "content"=>"6.6.6.6",
        #      "ttl"=>3600,
        #      "created_at"=>"2015-11-09T16:07:21+09:00",
        #      "updated_at"=>"2015-11-09T16:22:17+09:00",
        #      "priority"=>nil}
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
