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
        # @example
        #   response =
        #       client.create_zone(
        #          name: "foobar.example.com",
        #          email: "foobar@example.com",
        #          description: "description",
        #          default_ttl: 600
        #      )
        #
        #   response.uuid #=> UUID of a new zone
        def create_zone(attributes, headers = {})
          Validators::Zone.validate_attributes!(attributes, :create)
          post!("zones", attributes, headers)
        end

        # Delete a zone.
        #
        # @param uuid [String] UUID of target zone
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        # @example
        #   response =
        #       client.delete_zone("e8866e73-c843-484f-869a-62ba8301cf72")
        #   response.status #=> 200
        def delete_zone(uuid, headers = {})
          delete!("zones/#{uuid}", {}, headers)
        end

        # Get a zone.
        #
        # @param uuid [String] UUID of target zone
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        # @example
        #   response =
        #       client.get_zone("e8866e73-c843-484f-869a-62ba8301cf72")
        #   response.body #=>
        #   {"uuid"=>"e8866e73-c843-484f-869a-62ba8301cf72",
        #   "name"=>"foobar.example.com",
        #       "default_ttl"=>600,
        #       "created_at"=>"2015-10-30T17:41:10+09:00",
        #       "updated_at"=>nil,
        #   "records"=>
        #       [{"uuid"=>"72957c14-1f61-4c9d-91b2-e46df9821af7",
        #         "name"=>"foobar.example.com",
        #         "type"=>"SOA",
        #         "content"=>
        #             {"dns"=>"ns01.idcfcloud.com",
        #              "email"=>"foobar.example.com.",
        #              "serial"=>1,
        #              "refresh"=>10800,
        #              "retry"=>3600,
        #              "expire"=>604800,
        #              "ttl"=>3600},
        #         "ttl"=>3600,
        #         "created_at"=>"2015-10-30T17:41:10+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"fa31e338-4a77-42dd-8cf4-f525d8e0b47b",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns01.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-10-30T17:41:10+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"73e4847f-4167-463a-91e4-39c118eaf6d3",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns02.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-10-30T17:41:10+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"7c8ec697-636d-46a5-ad8c-e7f58484a8d5",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns03.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-10-30T17:41:10+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil}],
        #       "description"=>"description",
        #       "authenticated"=>false}
        #
        def get_zone(uuid, headers = {})
          get!("zones/#{uuid}", {}, headers)
        end

        # Get list of existing zones
        #
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        # @example
        #   client.list_zones.body #=>
        #     [{"uuid"=>"08af90fe-380b-4553-ae79-ad8630f3dfa3",
        #       "name"=>"foobar.example.com",
        #       "default_ttl"=>600,
        #       "created_at"=>"2015-10-30T17:41:10+09:00",
        #       "updated_at"=>nil,
        #       "description"=>"description",
        #       "authenticated"=>false},
        #      {"uuid"=>"f349b480-1cbe-4080-8fd7-b8fb8f219b3a",
        #       "name"=>"foobarfoo.example.com",
        #       "default_ttl"=>600,
        #       "created_at"=>"2015-11-04T10:59:44+09:00",
        #       "updated_at"=>nil,
        #       "description"=>"description",
        #       "authenticated"=>false}]
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
        # @example
        #   response =
        #       client.update_zone(
        #         "7c0d0952-e5be-45a1-b7d7-32fe88dc4458",
        #         description: "change description",
        #         default_ttl: 3600
        #       )
        #   response.status #=> 200
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
