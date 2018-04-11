require 'mechanize'
require 'json'

module DataServer
  module ParseSymbols
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
      page.body
    end

    def split_response_on_newline body
      body.split( /\r?\n/ )
    end

    def gsub_colon_for_space array
      new_array = []
      array.map do |elem|
        new_array << elem.gsub!(":", " ")
      end
      new_array
    end

    def new_listings page_body
      parsed_body = split_response_on_newline page_body
      formatted_list = gsub_colon_for_space parsed_body # convert format of incoming page data
      all_stock_symbols = all_stock_symbols # get all stocks from model
      formatted_stock_symbols = all_stocks_symbols_to_array all_stock_symbols # Get all ticker fields, store in array
      symbols_to_add = collect_stock_symbols formatted_list, formatted_stock_symbols

      symbols_to_add
    end

    def all_stock_symbols
      StockSymbol.all
    end

    def collect_stock_symbols incoming_data, stored_data
      return incoming_data if stored_data.empty?
      new_listings = []
      incoming_data.map { |e| new_listings << e if stored_data.include?(e.split(' ').first) }
      new_listings
    end

    def all_stocks_symbols_to_array ar_relation
      return [] if ar_relation.nil?
      tickers = []
      ar_relation.each do |rec|
        tickers << rec.ticker
      end
      tickers
    end

    def store_new_stocks_symbols array
      array.map do |elem|
        ticker_company_name = elem.split(' ', 2)
        ticker = ticker_company_name.first
        company_name = ticker_company_name.last
        StockSymbol.create!(ticker: ticker, company_name: company_name)
      end
    end
  end
end
