require 'mechanize'
require 'json'

module Barchart
  module BarchartDataParser
    extend self

    def parse_response_body page
      JSON.parse(page.body)
    end

    def parse_count body
      body['count']
    end

    def parse_total body
      body['total']
    end

    def parse_data body
      body['data']
    end

    def parse_stock_symbols body
      all_stock_symbols = []
      body.each { |hash| all_stock_symbols << hash.values_at("symbol") }
      all_stock_symbols
    end
  end
end
