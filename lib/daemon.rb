require 'tweetstream'

Dir["#{File.join(File.dirname(__FILE__), "daemon")}/*.rb"].each do |lib|
  require lib
end

# require applications
Dir["#{File.join(File.dirname(__FILE__), "applications")}/*.rb"].each do |application|
  require application
end


module Daemon
  class Daemon
    attr_accessor :users

    def initialize # 
      @applications = APPLICATIONS.map { |ac| ac.new }
      configure_api
    end

    def configure_api
      TweetStream.configure do |config|
        config.consumer_key       = 'X5sbEkdNPXBbd2c8hqog' # TODO
        config.consumer_secret    = 'bPeAmHaUdH4J5mY8n9NpGvcvtlCxIuUrcXSvJjkc'
        config.oauth_token        = '460113372-uNucdi2XaWwmVeAxyTNSEb0z0qXRFOfaylg7ECLj'
        config.oauth_token_secret = 'xFrY9FSPca0cCFjAxKDk3mGGHyJI94MXac0a1y5pBI'
        config.auth_method        = :oauth
      end
    end

    def run
      TweetStream::Client.new.track(*Configuration::HASHTAGS) do |status|
        handle_status(status)
      end
    end

    def handle_status(status)
      return unless status.top3_hashtag? # TODO necessary?

      @applications.each do |a|
        break if a.handle(status, status.user)
      end
      # users[update.username].update(update)
      # puts "Calling #{@handler}"
      # @handler.call(update.to_h)
    end
  end
end
