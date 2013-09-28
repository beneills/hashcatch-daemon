module Daemon

  # A user.  This encapsulates both the Twitter user data,
  #   and the Rails Model access methods.
  class DaemonUser
    attr_reader :username, :twitter, :rails

    def initialize(twitter_user)
      @username = twitter_user.username
      @twitter = twitter_user
      @rails = get_user(@username)
    end

    def get_user(username)
      Application.rails(username) do |username|
        u = User.find_by_username(username)
        if u.nil?
          u = User.create(username: username)
        end
        u
      end
    end
  end
end
