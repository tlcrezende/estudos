OpenAI.configure do |config|
  config.access_token = Rails.application.credentials.dig(:open_ai, :access_token)
  config.request_timeout = 10
end