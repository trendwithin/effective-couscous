require 'mechanize'
require 'json'

module Barchart
  module BarchartDataParser
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

    def parse_count body
      body['count']
    end

    def parse_total body
      body['total']
    end

    def parse_stock_symbols body
      all_stock_symbols = []
      body['data'].each { |hash| all_stock_symbols << hash.values_at("symbol") }
      all_stock_symbols
    end
  end
end
