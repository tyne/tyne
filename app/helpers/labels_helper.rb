# View helpers for labels
module LabelsHelper
  # Determines if a label is assigned to an issue
  def labelled?(label, issue)
    return false unless issue

    label.issues.include?(issue)
  end

  # Returns the associated label identifier
  def labelled_id(label, issue)
    return unless issue

    labelled = label.issue_labels.find_by_issue_id(issue.id)
    labelled.id if labelled
  end

  # Renders a tag for a label.
  def tag_for_label(label)
    style = "background-color: #{label.colour}; color:#{black_or_white(label.colour)}"
    content_tag :span, label.name, :class => "tag", :title => label.name, :style => style
  end

  private
  def black_or_white(colour)
    if bright?(colour)
      "#000000"
    else
      "#FFFFFF"
    end
  end

  def bright?(colour)
    red = colour[1,2].to_i(16)
    green = colour[3,2].to_i(16)
    blue = colour[5,2].to_i(16)

    luminance_standard(red, green, blue) > (255/2)
  end

  def luminance_standard(red, green, blue)
    return (0.2126*red) + (0.7152*green) + (0.0722*blue);
  end
end
