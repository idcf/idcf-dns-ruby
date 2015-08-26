require "faraday"
require "faraday_middleware"

module Idcf
  module Dns
    # Client for IDCF DNS service
    class Client
      include ClientExtensions::Record
      include ClientExtensions::Zone

      attr_reader :api_key, :secret_key, :host, :endpoint

      # The constructor of Dns::Client uses keyword arguments.
      #
      # @param [String] api_key API key for IDCF Cloud
      # @param [String] secret_key Secret key for IDCF Cloud
      def initialize(api_key:,
                     secret_key:,
                     host: "dns.idcfcloud.com",
                     endpoint: "/api/v1",
                     verify_ssl: true
                    )

        @api_key    = api_key
        @secret_key = secret_key
        @host       = host
        @endpoint   = endpoint
        @verify_ssl = verify_ssl
      end

      # @private
      def connection
        @connection ||=
          Faraday.new(url: url_prefix, ssl: ssl_options) do |connection|
            connection.request :json
            connection.response :json
            connection.adapter Faraday.default_adapter
          end
      end

      # Send DELETE request.
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def delete(resource, parameters = {}, headers = {})
        send(:delete, resource, parameters, headers)
      end

      # Send DELETE request with handling error
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def delete!(resource, parameters = {}, headers = {})
        send_with_handling_error(:delete, resource, parameters, headers)
      end

      # Send GET request
      #
      # @param resource [String] Resource name
      # @param parameters [Hash] Parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def get(resource, parameters = {}, headers = {})
        send(:get, resource, parameters, headers)
      end

      # Send GET request with handling error
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def get!(resource, parameters = {}, headers = {})
        send_with_handling_error(:get, resource, parameters, headers)
      end

      # Send POST request
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def post(resource, parameters = {}, headers = {})
        send(:post, resource, parameters, headers)
      end

      # Send POST request with handling error
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def post!(resource, parameters = {}, headers = {})
        send_with_handling_error(:post, resource, parameters, headers)
      end

      # Send PUT request
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def put(resource, parameters = {}, headers = {})
        send(:put, resource, parameters, headers)
      end

      # Send PUT request with handling error
      #
      # @param resource [String] resource name
      # @param parameters [Hash] request parameters
      # @param headers [Hash] HTTP request headers
      # @return [Response] Response object
      def put!(resource, parameters = {}, headers = {})
        send_with_handling_error(:put, resource, parameters, headers)
      end

      private

      def send(method, resource, parameters = {}, headers = {})
        Request.new(self, method, resource, parameters, headers).send
      end

      def send_with_handling_error(method, resource, parameters = {}, headers = {})
        response = send(method, resource, parameters, headers)
        unless response.success?
          fail(
            ApiError,
            "HTTP status code: #{response.status}, " \
            "Error message: #{response.message}, " \
            "Reference: #{response.reference}"
          )
        end
        response
      end

      def ssl_options
        { verify: @verify_ssl }
      end

      def url_prefix
        "https://#{host}"
      end
    end
  end
end
