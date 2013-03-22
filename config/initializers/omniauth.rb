Rails.application.config.middleware.use(OmniAuth::Builder) do
  begin
    provider :github, APP_CONFIG.omniauth.github.client_id, APP_CONFIG.omniauth.github.client_secret
  rescue
    raise "Please add your github API credentials to config/tyne.yml"
  end
end
