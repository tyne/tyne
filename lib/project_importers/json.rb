module ProjectImporters
  # ProjectImporter based on a JSON string
  class JSON
    attr_reader :user, :data

    def initialize(user)
      @user = user
    end

    # Performs the import.
    # == Usage
    #     importer = ProjectImporters::JSON.new(current_user)
    #     importer.import(:data => my_json_string)
    #
    # Where the JSON structure needs to be as follows:
    #    {
    #      :project => {
    #        :key => "FOO",
    #        :name => "Foo",
    #        :issues => [{
    #          :summary => "Issue 1",
    #          :description => "Issue description"
    #        }, {
    #          :summary => "Issue 2",
    #          :description => "Issue description"
    #        }]
    #    }
    def import(*args)
      options = args.extract_options!
      @data = Hashie::Mash.new(::JSON.parse(options[:data]))

      create_project
    end

    private
    def create_project
      project = Project.create! do |p|
        p.key = data.project[:key]
        p.name = data.project.name
        p.user = user
      end

      create_issues(project)
    end

    def create_issues(project)
      data.project.issues.each do |value|
        project.issues.create! do |issue|
          issue.summary = value.summary
          issue.description = value.description
          issue.reported_by = user
        end
      end
    end
  end

  register :json, JSON
end
