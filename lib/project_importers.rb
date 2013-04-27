# Namespace with functionality to import projects
module ProjectImporters
  # Exception class when imported is not available
  class NoImporterError < StandardError; end

  # Registers a new importer with the given key
  # and adds it to the collection.
  # @param [Symbol] key
  # @param [ProjectImporters::Base] importer
  def self.register(key, importer)
    registered_importers[key] = importer
  end

  # Returns the collection of registered importers
  # @return [ProjectImporters::Base]
  def self.registered_importers
    @@registered_importers ||= {}
  end

  # Creates a new instance of importer with the given key
  # @param [Symbol] key
  # @param [User] importer the user who initiates the import
  # @return [ProjectImporters::Base]
  # @raise [ProjectImporters::NoImporterError] if the given key does not exist
  def self.obtain(key, importer)
    raise NoImporterError unless registered_importers.include?(key)
    registered_importers[key].new(importer)
  end

  autoload :JSON, "project_importers/json"
end
