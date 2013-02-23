# Handles administrative project requests
class AdminController < ApplicationController
  def is_admin_area?
    true
  end
end
