require 'mechanize'
require 'json'

module Barchart
  module BarchartApiParser
    extend self

    def fetch_url url, max_attempts = 5
      tries ||= 0
      Mechanize.new.get url
      rescue SocketError => se
        if (tries += 1) <= max_attempts
          retry
        else
          raise se
        end
      rescue Mechanize::ResponseCodeError => rce
        if (tries += 1) <= max_attempts
          retry
        else
          raise rce
        end
    end

    def parse_response_body page
      JSON.parse(page.body)
    end
  end
end
