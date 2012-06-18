Recaptcha.configure do |config|
  config.public_key  = Raddar::config.recaptcha['public_key']
  config.private_key = Raddar::config.recaptcha['private_key']
  config.proxy = Raddar::config.recaptcha['proxy']
end