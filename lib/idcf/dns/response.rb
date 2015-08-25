require "forwardable"

module Idcf
  module Dns
    # HTTP response
    class Response
      extend Forwardable

      # @!attribute [r] body
      #   @return [Hash, Array, nil] response body as a hash,
      #     an array of hashes or nil.
      # @!attribute [r] headers
      #   @return [Hash] HTTP response headers
      # @!attribute [r] status
      #   @return [Integer] HTTP status code
      attr_reader :body, :headers, :status

      # @param faraday_response [Faraday::Response]
      def initialize(faraday_response)
        @body    = faraday_response.body
        @headers = faraday_response.headers
        @status  = faraday_response.status
      end

      def_delegator :@body, :[]

      # Returns the number of resources.
      #
      # @return [Fixnum] count of resources.
      def count
        case body
        when Array
          body.size
        when Hash
          if body.key?("uuid")
            1
          else
            0
          end
        else
          0
        end
      end
      alias_method :size, :count

      # Returns error message.
      # When request succeed, this returns nil.
      #
      # @return [String] API error message
      def message
        if success?
          nil
        else
          body ? self["message"] : "Resource not found."
        end
      end

      # Returns error reference.
      # When request succeed, this returns nil.
      #
      # @return [String] API error reference
      def reference
        if success?
          nil
        else
          body ? self["reference"] : "No reference"
        end
      end

      # Returns an array of resource hashes.
      #
      # @return [Array<Hash>] an array of resource hashes
      def resources
        body && [*body]
      end

      # @return [Boolean] request success?
      def success?
        status < 400
      end

      # @return [String] UUID of a resource
      def uuid
        body.is_a?(Hash) && body.key?("uuid") ? self["uuid"] : nil
      end
    end
  end
end
