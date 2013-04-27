# Handles import request
class ImportsController < ApplicationController
  # Renders a list of all available importers
  def index
    @importers = ProjectImporters.registered_importers
  end

  # Renders the partial for the given provider
  def provider
    render "imports/_#{params[:provider]}"
  end

  # Peforms the import.
  def perform
    provider = params.delete(:provider)
    ProjectImporters.obtain(provider.to_sym, current_user).import(params)
  end
end
