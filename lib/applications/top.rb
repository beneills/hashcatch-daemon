module Daemon
  module Top
    $list_size = 3
    $categories = { :album => ['cd', 'disc'],
      :book => ['novel', 'story'],
      :film => ['movie'] }

    # generate regexp
    $number_regexp = (1..$list_size).to_a.map(&:to_s).join('|')
    $regexp = /(my +)?((no)|#) *(favorite +)?(?<number>#{$number_regexp}) +(?<category>(album)|(cd)|(book)|(film)|(movie)) +(is +)?(?<name>[^#]+)/i

    class TopUpdate
      attr_accessor :category, :number, :name, :username

      def initialize(category_synonym, number, name, username)
        @category = validate_category(category_synonym)
        @number = validate_number(number)
        @name = validate_name(name)
        @username = username
      end


      def to_h
        {:category => @category,
          :place => @number,
          :text => @name,
          :link => ""}
     end

      def validate_category(synonym)
        synonym.downcase!
        hit = $categories.find do |category, synonyms|
          category.to_s == synonym or synonyms.include?(synonym)
        end
        raise ArgumentError, "Invalid category synonym: #{synonym}" if hit.nil?
        hit.first
      end

      def validate_number(number_string)
        i = number_string.to_i
        raise ArgumentError, "Invalid number: #{number_string}" unless (1..$list_size).include?(i)
        i
      end

      def validate_name(name)
        # TODO
        name.strip
      end
    end

    class TopApplication < RegexpApplication
      @@list_size = $list_size
      @@categories = $categories
      @@regexp = $regexp

      def initialize
        @regexp = @@regexp
      end

      def handle_match(status, user, match)
        puts "top handle_match()"
        update = TopUpdate.new(match[:category], match[:number], match[:name], user.username)
        rails(update) do |update|
          puts "user.rails.entries.create(#{update.to_h})"
          user.rails.top_entries.create(update.to_h)
        end
      end
    end

    Daemon::Application.register_application(TopApplication)
  end
end
