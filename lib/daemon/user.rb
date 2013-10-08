module Daemon

  # A user.  This encapsulates both the Twitter user data,
  #   and the Rails Model access methods.
  class DaemonUser
    include Logging

    attr_reader :username, :twitter, :rails

    def initialize(twitter_user)
      @username = twitter_user.username
      @twitter = twitter_user
#      puts "initialize user: #{twitter_user.profile_image_url.sub('normal.', 'bigger.')}"
      @rails = get_rails_user
    end

    def get_rails_user
      Application.rails(username) do |username|
        u = User.find_by_username(username)
        if u.nil?
          logger.info("Creating new user: #{username}")
          u = User.higher_level_create(twitter)
        end
        u
      end
    end
  end
end
