module Daemon

  # Example: logs statuses containing 'example' to /tmp/hashcatch_example.log
  #
  class ExampleApplication < Application
    @@logfile = '/tmp/hashcatch_example.log'
    @@keyword = 'example'

    def initialize
    end

    # Log to file, if possible
    #
    def handle(status, user)
      if status.text.include?(@@keyword)
        File.open(@@logfile, 'a') { |file|
          file.write("Handled status: #{status.text}\n")
        }
        true
      else
        false
      end
    end
  end

 # Daemon::Application.register_application(ExampleApplication)
end
