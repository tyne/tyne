#Generates cache keys for objects
class CacheKeyGenerator
  attr_reader :collection

  #Key for an active record collection/relation
  def for_collection(collection)
    @collection = collection

    if collection.empty?
      'empty/' + collection.object_id.to_s
    else
      key = ""
      key << collection_type
      key << "/#{collection.length}-"
      key << ids_hash
      key << "-#{max_created}-#{max_updated}"
      key
    end
  end

  private

  def collection_type
    collection.first.class.to_s.tableize
  end

  def ids_hash
      Digest::MD5.hexdigest(collection.collect{|item| item.id }.to_s)
  end


  def max_updated
    collection.map(&:updated_at).max.to_i
  end

  def max_created
    collection.map(&:created_at).max.to_i
  end
end
