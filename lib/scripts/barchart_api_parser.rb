require 'mechanize'
require 'json'

module Barchart
  module BarchartApiParser
    extend self

    # Consider a Refactor as method call for insert= only difference
    def map_response_and_return_formatted_record response_body
      results = { success: 0, errors: 0 }
      response_body['results'].map do |obj|
        insert = parse_data_from_api_response obj
        begin
          StockPriceHistory.create!(insert)
          results[:success] += 1
        rescue ActiveRecord::NotNullViolation => active_record_not_null
          results[:errors] += 1
        rescue PG::NotNullViolation => pg_not_null
          results[:errors] += 1
        rescue ActiveRecord::RecordInvalid => invalid
          Rails.logger.error "Potential Duplicate Daily Price Data: " +
            obj["symbol"]
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
        rescue ActiveRecord::NotNullViolation => active_record_not_null
          results[:errors] += 1
        rescue PG::NotNullViolation => pg_not_null
          results[:errors] += 1
        rescue ActiveRecord::RecordInvalid => invalid
          Rails.logger.errors "Potential Duplicate Historical Price Data: " +
            obj["symbols"] + " invalid"
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
