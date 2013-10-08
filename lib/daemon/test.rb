module Daemon
  class TestStatus
    attr_reader :user, :text

    @@user = Struct.new(:id,
                        :username,
                        :name,
                        :description,
                        :location,
                        :verified,
                        :profile_image_url).new(1053008011,
                                                'Testuser',
                                                'Test A. User',
                                                'fake account',
                                                nil,
                                                false,
                                                'https://si0.twimg.com/profile_images/1053008011/2010-07-04_Eric_Mueller__2___512x640__bigger.jpg')

    def initialize(text, user)
#      @user = @@user
      @text = text
    end
  end
end
