module Idcf
  module Dns
    module Resources
      # Zone resource class
      class Zone < Base
        # @return [Array<Record>] an array of records
        def records
          return @record_objects if @record_objects
          refresh
          @record_objects = @records.map { |record| Record.new(client, record) }
        end

        # Refresh this zone
        #
        # @return [Zone] self object
        def refresh
          self.attributes = client.get_zone(uuid).body
          self
        end
      end
    end
  end
end
