module Daemon
  class Example2Application# < RegexpApplication(/.*hello world(\d).*/i)
    def handle_match(status, user, match)
      puts "Handling Example2 status with number: #{match[1]}"
    end
  end

#  Daemon::Application.register_application(Example2Application)
end
