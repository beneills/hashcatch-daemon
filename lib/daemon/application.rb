module Daemon

  # List of application classes
  APPLICATIONS = []

  # In charge of handling updates intended for this applications
  #   consumption.
  #
  class Application
    def initialize
    end

    # Do stuff with the status update, if possible
    # Returns true or false to indicate whether we can handle this or not
    #
    def handle(status)
    end

    class << self
      # Must be called to enable an application
      #
      def register_application(application)
        APPLICATIONS.push(application)
      end
    end
  end
end
