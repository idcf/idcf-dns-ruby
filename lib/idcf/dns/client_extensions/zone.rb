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
        #        client.create_zone(
        #           name: "foobar.example.com",
        #           email: "foobar@example.com",
        #           description: "",
        #           default_ttl: 600
        #         )
        #
        #   response.body #=>
        #     {"uuid"=>"384178f5-58a5-4f3c-9607-5e189ab2990d",
        #      "name"=>"foobar.example.com",
        #      "default_ttl"=>600,
        #      "created_at"=>"2015-11-09T11:43:49+09:00",
        #      "updated_at"=>nil,
        #      "records"=>
        #       [{"uuid"=>"6aba1170-83b9-4324-b331-8c2b8dcb5162",
        #         "name"=>"foobar.example.com",
        #         "type"=>"SOA",
        #         "content"=>
        #          {"dns"=>"ns01.idcfcloud.com",
        #           "email"=>"foobar.example.com.",
        #           "serial"=>1,
        #           "refresh"=>10800,
        #           "retry"=>3600,
        #           "expire"=>604800,
        #           "ttl"=>3600},
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"0b18679d-dd47-46fe-8812-d20c284001ac",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns01.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"a5a9ab9c-b19f-4411-880e-842ffd53027c",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns02.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"2756ed66-2b69-4ae2-8065-69ac2b12b71d",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns03.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil}],
        #      "description"=>"",
        #      "authenticated"=>false}
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
        #       client.delete_zone("83f55e72-e3fa-4961-89b3-99ee43617b93")
        #
        #   response.body #=> {}
        #
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
        #       client.get_zone("b19e8211-e492-425d-b66a-7642dc2ff8fb")
        #
        #   response.body #=>
        #     {"uuid"=>"b19e8211-e492-425d-b66a-7642dc2ff8fb",
        #      "name"=>"foobar.example.com",
        #      "default_ttl"=>600,
        #      "created_at"=>"2015-11-09T11:43:49+09:00",
        #      "updated_at"=>nil,
        #      "records"=>
        #       [{"uuid"=>"1f30afd1-9b5e-45df-b03e-d07779a90e1c",
        #         "name"=>"foobar.example.com",
        #         "type"=>"SOA",
        #         "content"=>
        #          {"dns"=>"ns01.idcfcloud.com",
        #           "email"=>"foobar.example.com.",
        #           "serial"=>2,
        #           "refresh"=>10800,
        #           "retry"=>3600,
        #           "expire"=>604800,
        #           "ttl"=>3600},
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>"2015-11-09T11:43:50+09:00",
        #         "priority"=>nil},
        #        {"uuid"=>"b5322649-625d-4b50-8cd3-7542f64912fa",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns01.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"1fb4d44c-160a-45cd-835c-eb47fe1edb27",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns02.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"765f8426-70b8-46c6-a45b-836c5dd57a7d",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns03.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"ea81d8c0-8c6d-47e7-bca7-33656888a293",
        #         "name"=>"www.foobar.example.com",
        #         "type"=>"A",
        #         "content"=>"8.8.8.8",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:50+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil}],
        #      "description"=>"",
        #      "authenticated"=>false}
        def get_zone(uuid, headers = {})
          get!("zones/#{uuid}", {}, headers)
        end

        # Get list of existing zones
        #
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        # @example
        #   response =
        #       client.list_zones
        #
        #   response.body #=>
        #     [{"uuid"=>"384178f5-58a5-4f3c-9607-5e189ab2990d",
        #       "name"=>"foobar.example.com",
        #       "default_ttl"=>600,
        #       "created_at"=>"2015-11-09T11:43:49+09:00",
        #       "updated_at"=>nil,
        #       "description"=>"",
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
        #       "384178f5-58a5-4f3c-9607-5e189ab2990d",
        #       description: "Change description",
        #       default_ttl: 3600
        #       )
        #
        #   response.body #=>
        #     {"uuid"=>"384178f5-58a5-4f3c-9607-5e189ab2990d",
        #      "name"=>"foobar.example.com",
        #      "default_ttl"=>3600,
        #      "created_at"=>"2015-11-09T11:43:49+09:00",
        #      "updated_at"=>"2015-11-09T11:43:50+09:00",
        #      "records"=>
        #       [{"uuid"=>"6aba1170-83b9-4324-b331-8c2b8dcb5162",
        #         "name"=>"foobar.example.com",
        #         "type"=>"SOA",
        #         "content"=>
        #          {"dns"=>"ns01.idcfcloud.com",
        #           "email"=>"foobar.example.com.",
        #           "serial"=>2,
        #           "refresh"=>10800,
        #           "retry"=>3600,
        #           "expire"=>604800,
        #           "ttl"=>3600},
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>"2015-11-09T11:43:50+09:00",
        #         "priority"=>nil},
        #        {"uuid"=>"0b18679d-dd47-46fe-8812-d20c284001ac",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns01.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"a5a9ab9c-b19f-4411-880e-842ffd53027c",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns02.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"2756ed66-2b69-4ae2-8065-69ac2b12b71d",
        #         "name"=>"foobar.example.com",
        #         "type"=>"NS",
        #         "content"=>"ns03.idcfcloud.com",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:49+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil},
        #        {"uuid"=>"40d5f26f-02bd-4fb1-b363-323675772289",
        #         "name"=>"www.foobar.example.com",
        #         "type"=>"A",
        #         "content"=>"8.8.8.8",
        #         "ttl"=>3600,
        #         "created_at"=>"2015-11-09T11:43:50+09:00",
        #         "updated_at"=>nil,
        #         "priority"=>nil}],
        #      "description"=>"Change description",
        #      "authenticated"=>false}
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
