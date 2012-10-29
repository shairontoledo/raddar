# Use this setup block to configure all options available in PrivatePub.
PrivatePub.setup do |private_pub|
  private_pub.config['server'] = Raddar::config.respond_to?(:private_pub) ? Raddar::config.private_pub['server'] : 'http://localhost:9292/faye'
  private_pub.config['secret_token'] = Raddar::config.respond_to?(:private_pub) ? Raddar::config.private_pub['secret_token'] : 'secret_token'
  private_pub.config['signature_expiration'] = Raddar::config.respond_to?(:private_pub) ? Raddar::config.private_pub['signature_expiration'] : 3600
end