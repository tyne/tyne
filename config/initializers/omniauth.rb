Rails.application.config.middleware.use(OmniAuth::Builder) do
  if APP_CONFIG.omniauth && APP_CONFIG.omniauth.github
    provider :github, APP_CONFIG.omniauth.github.client_id, APP_CONFIG.omniauth.github.client_secret
  end
end
