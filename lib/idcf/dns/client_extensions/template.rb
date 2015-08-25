module Idcf
  module Dns
    module ClientExtensions
      # SDK APIs for template resource
      module Template
        # Create a new template.
        #
        # @param attributes [Hash] request attributes
        # @option attributes [String] :name unique name of template (required)
        # @option attributes [String] :description description
        # @option attributes [Integer] :default_ttl default TTL (required)
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def create_template(attributes, headers = {})
          Validators::Template.validate_attributes!(attributes, :create)
          post!("templates", attributes, headers)
        end

        # Delete a template.
        #
        # @param uuid [String] UUID of the target template
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def delete_template(uuid, headers = {})
          delete!("templates/#{uuid}", {}, headers)
        end

        # Get a template.
        #
        # @param uuid [String] UUID of the target template
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def get_template(uuid, headers = {})
          get!("templates/#{uuid}", {}, headers)
        end

        # Get list of existing templates.
        #
        # @param headers [Hash] HTTP request headers
        # @return [Response] HTTP response object
        def list_templates(headers = {})
          get!("templates", {}, headers)
        end

        # Update a template.
        #
        # @param uuid [String] UUID of the target template
        # @param attributes [Hash] request attributes
        # @option attributes [String] :description
        # @option attributes [Integer] :default_ttl default TTL
        # @return [Reponse] HTTP response object
        def update_template(uuid, attributes, headers = {})
          Validators::Template.validate_attributes!(attributes, :update)
          put!("templates/#{uuid}", attributes, headers)
        end
      end
    end
  end
end
