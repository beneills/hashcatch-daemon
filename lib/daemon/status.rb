module Daemon
  class Twitter::Status
    # is this Status intended as a top3 update?
    def top3_hashtag?
      Configuration::HASHTAGS.map { |tag| text.include?(tag) }.any?
    end
  end
end
