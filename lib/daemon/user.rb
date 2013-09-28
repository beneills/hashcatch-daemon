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
      puts "get_user()"
      Application.rails(username) do |username|
        puts "calling rails:user.find_...(#{username})"
#        puts (Rails::User.methods - Object.methods)
        u = User.find_by_username(username)
        puts "found user: #{u}"
        if u.nil?
          puts "u == nil"
          u = User.new(username: username)
          u.save # TODO
        end
        puts "Return #{u}"
        puts #{u.username}"
        u
      end
    end
  end
end
