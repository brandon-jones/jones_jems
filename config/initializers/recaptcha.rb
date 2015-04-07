Recaptcha.configure do |config|
  config.public_key  = ENV["JJ_CAPTCHA_SITE_KEY"]
  config.private_key = ENV["JJ_CAPTCHA_SECRET_KEY"]
  config.api_version = 'v2'
end