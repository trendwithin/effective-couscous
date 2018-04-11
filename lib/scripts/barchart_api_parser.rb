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

    def map_response_and_return_formatted_record response_body
      results = { success: 0, errors: 0 }
      response_body['results'].map do |obj|
        insert = parse_data_from_api_response obj
        begin
          StockPriceHistory.create!(insert)
          results[:success] += 1
        rescue ActiveRecord::NotNullViolation => record_not_null
          results[:errors] += 1
        rescue PG::NotNullViolation => pg_not_null
          results[:errors] += 1
        end
      end
      results
    end

    def map_response_and_return_historical_record response_body
      results = { success: 0, errors: 0 }
      response_body['results'].map do |obj|
        insert = parse_historical_data_from_api_response obj
        begin
          StockPriceHistory.create!(insert)
          results[:success] += 1
        rescue ActiveRecord::NotNullViolation => record_not_null
          results[:errors] += 1
        rescue PG::NotNullViolation => pg_not_null
          results[:errors] += 1
        end
      end
      results
    end

    def parse_historical_data_from_api_response obj
      format_obj = {}
      format_obj[:market_close_date] = obj['tradingDay']
      format_obj[:ticker] = obj['symbol']
      format_obj[:company_name] = 'DEFAULT'
      format_obj[:open] = obj['open']
      format_obj[:high] = obj['high']
      format_obj[:low] = obj['low']
      format_obj[:close] = obj['close']
      format_obj[:last_price] = 100000
      format_obj[:percent_change] = 1
      format_obj[:net_change] = 100000
      format_obj[:volume] = obj['volume']

      format_obj
    end

    def parse_data_from_api_response obj
      format_obj = {}
      format_obj[:market_close_date] = DateTime.now.strftime("%d-%m-%Y")
      format_obj[:ticker] = obj['symbol']
      format_obj[:company_name] = obj['name']
      format_obj[:open] = obj['open']
      format_obj[:high] = obj['high']
      format_obj[:low] = obj['low']
      format_obj[:close] = obj['close']
      format_obj[:last_price] = obj['lastPrice']
      format_obj[:percent_change] = obj['percentChange']
      format_obj[:net_change] = obj['netChange']
      format_obj[:volume] = obj['volume']

      format_obj
    end
  end
end
