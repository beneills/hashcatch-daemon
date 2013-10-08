require 'uri'
require 'open-uri'

module Daemon
  module Cite

    url_regexp = "[\\S]+" # TODO

    $regexp = /((cite)|(archive)) +(?<url>#{url_regexp})( +(?<note>[^#]+))?/i


    class CiteUpdate < Update
      include Logging

      attr_accessor :url, :note, :username

      def initialize(tweet, url, note, user)
        @tweet = tweet
        @url = full_url url
        @note = note
        @user = user

        logger.debug("Initialize CiteUpdate(#{@url}, #{@note}, #{@user.username})")
      end

      def full_url url
        if url.start_with?("http")
          url
        else
          "http://" + url
        end
      end

      def to_h
        {:tweet => @tweet,
          :url => @url,
          :note => @note}
      end
    end

#class NewsletterJob < Struct.new(:text, :emails)
#end

#Delayed::Job.enqueue NewsletterJob.new('lorem ipsum...', Customers.find(:all).collect(&:email))

    class CiteApplication < RegexpApplication
      @@regexp = $regexp
      @@updates = []

      def initialize
        @regexp = @@regexp
      end

      def handle_match(status, user, match)
        update = CiteUpdate.new(status.text, match[:url], match[:note], user)
        @@updates.push(update)
        puts 1        
        rails(update) do |update|
          puts 2
          e = user.rails.cite_entries.create(update.to_h)
          puts 3
          # and actually cite it
          puts "delaying"

          e.delay.fetch_archive_url
        end
      end
    end

    Daemon::Application.register_application(CiteApplication)
  end
end
