# The NotificationCell class represents the notification bar that is used
# to display success, error and otherwise classified messages
class NotificationCell < Cell::Rails
  # Shows the notification cell
  def show
    render
  end
end
