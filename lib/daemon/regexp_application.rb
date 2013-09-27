module Daemon

  # Returns a new class with TODO
  #
  #
  class RegexpApplication < Application
    # Do stuff with the status update, if possible
    # Returns true or false to indicate whether we can handle this or not
    #
    def handle(status, user)
      m = @regexp.match(status.text)
      if m.nil?
        false
      else
        handle_match(status, user, m)
        true
      end
    end

    # Override to control behaviour upon match
    #
    def handle_match(status, user, match); end
  end
end  

