module Daemon
  class TestStatus
    attr_reader :user, :text

    def initialize(text)
      @user = Struct.new(:username).new('Testuser')
      @text = text
    end
  end
end
