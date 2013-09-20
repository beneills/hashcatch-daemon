module Daemon
  class User
    attr_reader :username

    def initialize(username)
      @data = Hash.new(Hash.new) # { :cat1 => {1 => 'one', 3 => 'three} }
    end

    def update(u)
      cat = @data[u.category]
      # possibly shift existing values
      if cat.has_key?(u.number)
        lowest = (((1..Configuration::LIST_SIZE).to_a - cat.keys).sort.first or Configuration::LIST_SIZE)
        (u.number.next..lowest).to_a.reverse.each do |i|
          cat[i] = cat[i-1]
        end
      end
      cat[u.number] = u.name
    end

    
    def to_s
      "<User #{@username}\n    #{@data}>"
    end
  end
end
