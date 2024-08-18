Yt.configure do |config|
  config.api_key = Rails.application.credentials.dig(:google, :youtube, :api_key)
  config.log_level = :debug
end