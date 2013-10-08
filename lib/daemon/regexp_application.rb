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
        logger.info("No regexp match for: #{self.class}")
        false
      else
        logger.info("Regexp match for: #{self.class}, handling.")
        handle_match(status, user, m)
        true
      end
    end

    # Override to control behaviour upon match
    #
    def handle_match(status, user, match); end
  end
end  

