# Represents a create button for issues
class IssueCell < Cell::Rails
  # Renders a new create button for issue creation
  #
  # @param [String] dialog_path PJAX path to the dialog
  def create(dialog_path)
    @dialog_path = dialog_path
    render
  end
end
