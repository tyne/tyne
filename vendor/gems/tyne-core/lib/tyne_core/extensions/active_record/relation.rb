module TyneCore
  module Extensions
    # ActiveRecord extensions
    module ActiveRecord
      # Extensions for ActiveRecord::Relation
      module Relation
        extend ActiveSupport::Concern

        # Generate a cache key for active record relations
        def cache_key
          if self.empty?
            'empty/' + self.object_id.to_s
          else
            ids_hash = Digest::MD5.hexdigest(self.collect{|item| item.id }.to_s)
            update_timestamp = max {|a,b| a.updated_at <=> b.updated_at }.updated_at.to_i.to_s
            create_timestamp = max {|a,b| a.created_at <=> b.created_at }.created_at.to_i.to_s
            self.first.class.to_s.tableize+'/'+length.to_s+'-'+ids_hash+'-'+create_timestamp+'-'+update_timestamp
          end
        end
      end
    end
  end
end

ActiveRecord::Relation.send(:include, TyneCore::Extensions::ActiveRecord::Relation)
