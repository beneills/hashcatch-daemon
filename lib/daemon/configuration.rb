module Daemon
  class Configuration
    LIST_SIZE = 3
    NUMBER_REGEX = (1..LIST_SIZE).to_a.map(&:to_s).join('|')
    HASHTAG = "#toptest"

    STATUS_REGEX = /(my +)?((no)|#) *(?<number>#{NUMBER_REGEX}) +(?<category>(album)|(cd)|(book)|(film)|(movie)) +(is +)?(?<name>[^#]+)/i

    CATEGORIES = { :album => ['cd', 'disc'],
      :book => ['novel', 'story'],
      :film => ['movie'] }
  end
end
