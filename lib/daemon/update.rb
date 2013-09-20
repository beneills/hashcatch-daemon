module Daemon
  class Update
    attr_accessor :category, :number, :name, :username

    def initialize(category_synonym, number, name, username)
      @category = get_category(category_synonym)
      @number = validate_number(number)
      @name = validate_name(name)
      @username = username
    end

    def get_category(synonym)
      synonym.downcase!
      Configuration::CATEGORIES .map do |category, synonyms|
        return category if category.to_s == synonym or synonyms.include?(synonym)
      end
      raise "Invalid category synonym: #{synonym}"
    end

    def to_h
      {:username => @username,
        :category => @category,
        :place => @number,
        :text => @name,
        :link => ""}
    end

    def validate_number(number)
      raise "Invalid number: #{number}" unless number.match(Configuration::NUMBER_REGEX)
      number.to_i
    end

    def validate_name(name)
      # TODO
      name.strip
    end
  end
end
