module Daemon
  class Twitter::Status
    # is this Status intended as a top3 update?
    def top3_hashtag?
      text.include?(Configuration::HASHTAG)
    end
    
    # parse, returning Update instance
    def parse
      r = text.match(Configuration::STATUS_REGEX)
      raise "Status parsing error: no regex match" unless r
#      Update.new(r[:category], r[:number], r[:name], "TestUser") # user.username) TODO
      Update.new(r[:category], r[:number], r[:name], user.username)
    end
  end
end
