require 'mechanize'
require 'json'

module Barchart
  module BarchartDataParser
    def fetch_url url
      Mechanize.new.get url
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

# module Barchart
#   class Scraper
#      attr_reader :page
#
#      def initialize url = ''
#        @page = Mechanize.new.get url
#      end
#
#      def parse_response_body
#        JSON.parse(@page.body)
#      end
#
#      def parse_total_count
#
#      end
#   end
# end
