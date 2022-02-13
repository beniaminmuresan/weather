# frozen_string_literal: true

# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept cross-origin AJAX requests.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # TODO: add the actual client endpoints before we release the app in order to restrict access to anyone else
    origins '*'

    resource '*',
             headers: :any,
             expose: %i[total-count total-pages page-items current-page],
             methods: %i[get post put patch delete options head]
  end
end
