require 'tweetstream'

Dir["#{File.join(File.dirname(__FILE__), "daemon")}/*.rb"].each do |lib|
  require lib
end


module Daemon
  class Daemon
    attr_accessor :users

    def initialize(handler)
      @handler = handler
      @users = Hash.new { |h, k| h[k] = User.new(k) }
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
      # This will pull a sample of all tweets based on
      # your Twitter account's Streaming API role.
      TweetStream::Client.new.track(Configuration::HASHTAG) do |status|
        puts "RECV"
        handle_status(status)
      end
    end

    def handle_update(update)
      puts "Handling update"
      users[update.username].update(update)
      puts "Calling #{@handler}"
      @handler.call(update.to_h)
      puts "called"
      puts users # TODO
    end

    def handle_status(status)
      return unless status.top3_hashtag?
#      begin
      update = status.parse
      handle_update(update)
#      rescue
#        puts "could not parse" # TODO
#        raise
#      end
    end
  end
end
