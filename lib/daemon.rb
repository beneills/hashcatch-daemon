require 'readline'
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
    include Logging

    attr_accessor :users

    def initialize
      # TODO
      Delayed::Worker.destroy_failed_jobs = false

      logger.info("Intiatialize Daemon")
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
      logger.info("Daemon Running")
      TweetStream::Client.new.track(*Configuration::HASHTAGS) do |status|
        handle_status(status)
      end
    end

    def manual_run
      Twitter.configure do |config|
        config.consumer_key       = 'X5sbEkdNPXBbd2c8hqog'
        config.consumer_secret    = 'bPeAmHaUdH4J5mY8n9NpGvcvtlCxIuUrcXSvJjkc'
        config.oauth_token        = '460113372-uNucdi2XaWwmVeAxyTNSEb0z0qXRFOfaylg7ECLj'
        config.oauth_token_secret = 'xFrY9FSPca0cCFjAxKDk3mGGHyJI94MXac0a1y5pBI'
      end

      puts "Daemon manually running as @beneills. #hc automatically appended."

      user = Twitter.user("beneills")

      while tweet = Readline.readline("> ", true).concat(' #hc')
        puts "<#{tweet}>"

        handle_status(TestStatus.new(tweet, user))
      end
    end

    def handle_status(status)
      logger.info("Handling Status: #{status.text}")

      user = DaemonUser.new(status.user)

      handler = @applications.find do |a|
        a.handle(status, user)
      end

      if handler.nil?
        logger.info("No handler!")
      else
        logger.info("Handled by: #{handler}")
      end
    end
  end
end
