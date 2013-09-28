module Daemon

  # A user.  This encapsulates both the Twitter user data,
  #   and the Rails Model access methods.
  class User
    attr_reader :username, :twitter, :rails

    def initialize(twitter_user)
      @username = twitter_user
      @twitter = twitter_user
      @rails = get_user(@username)
    end

    def get_user(username)
      Application.rails(username) do |username|
        u = User.find_by_username(username)
        if u.nil?
          u = User.new(username: username)
          u.save # TODO
        end
        u
      end
    end
  end
end
