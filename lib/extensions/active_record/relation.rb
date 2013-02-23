module Extensions
  # ActiveRecord extensions
  module ActiveRecord
    # Extensions for ActiveRecord::Relation
    module Relation
      extend ActiveSupport::Concern

      # Generate a cache key for active record relations
      def cache_key
        CacheKeyGenerator.new.for_collection(self)
      end
    end
  end
end

ActiveSupport.on_load(:active_record) do
  ActiveRecord::Relation.send(:include, Extensions::ActiveRecord::Relation)
end
