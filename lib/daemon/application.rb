module Daemon

  # List of application classes TODO class variable
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
    def handle(status, user)
    end

    # run the block only if we are connected to Rails
    #
    def rails(*args, &block)
      if Configuration::TEST
        puts('Pretend rails: ' + args.map { |a| a.inspect }.join(', '))
      else
        puts "Real DB!" # TODO
        #db_method.call(*args)
        #block.call(*args) unless Configuration::TEST
      end
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