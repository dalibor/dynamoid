module Dynamoid
  module Tasks
    module Database
      extend self

      # Create any new tables for the models. Existing tables are not
      # modified.
      def create_tables
        results = { created: [], existing: [] }
        Dynamoid.included_models.each do |model|
          if Dynamoid.adapter.list_tables.include? model.table_name
            results[:existing] << model.table_name
          else
            model.create_table
            results[:created] << model.table_name
          end
        end
        results
      end

      # Is the DynamoDB reachable?
      def ping
        Dynamoid.adapter.list_tables
        true
      end

    end
  end
end
