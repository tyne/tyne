# Represents a pod element
class PodCell < Cell::Rails
  attr_accessor :content

  # Renders a collapsable pod
  def collapsable(title, options={})
    @title = title
    @features = [:collapsable]
    @state = options[:state] || :expanded;
    @content_style = if @state == :expanded
                       "display: block;"
                     else
                       "display: none;"
                     end

    render :file => 'pod/show'
  end
end
