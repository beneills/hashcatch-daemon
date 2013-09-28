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
#      class TUser < Struct.new(:username); end
      user = DaemonUser.new(Struct.new(:username).new('james'))
      puts user.rails
      puts user.rails.class
#      puts user.methods
#      puts (user.rails.methods - Object.new.methods).sort
#      puts user.rails.username
      h = {:username => user.rails.username,
        :category => 'book',
        :place => '3',
        :text => 'hobbit',
        :link => ""}
      user.rails.entries.create(h)
      exit 1

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
      puts "run()"
      TweetStream::Client.new.track(*Configuration::HASHTAGS) do |status|
        handle_status(status)
      end
    end

    def handle_status(status)
      puts "handle_status()"
      return unless status.top3_hashtag? # TODO necessary?

      puts "getting user"
      user = DaemonUser.new(status.user)
      puts "user = #{user}"

      handler = @applications.find do |a|
        a.handle(status, user)
      end

      if handler.nil?
        puts "No handler!"
      else
        puts "Handled by #{handler}"
      end
    end
  end
end
