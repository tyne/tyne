# Helper for notifications
module NotificationHelper
  # uses the Notification cell to display flash messages
  def flash_notification
    unless flash.empty?
      classification = flash.keys.first
      message = flash[classification]

      javascript_tag "$(function() { Notification.show('#{classification}', '#{message}'); });"
    end
  end
end
