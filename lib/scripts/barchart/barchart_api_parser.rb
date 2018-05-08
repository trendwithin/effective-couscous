require 'mechanize'
require 'json'

module Barchart
  module BarchartApiParser
    extend self

    def response_body_results response_body
      response_body['results']
    end

    def insert_historical_data results, time_period = :daily
      period = time_period == :historical ? "Historical" : "Daily"
      parse_method = time_period == :historical ?
        "parse_historical_data_from_api_response" : "parse_data_from_api_response"

      validations = { success: 0, errors: 0 }
      results.map do |obj|
        insert = send(parse_method, obj)
        begin
          StockPriceHistory.create!(insert)
          puts 'Inserted'
          validations[:success] += 1
        rescue ActiveRecord::NotNullViolation => active_record_not_null
          validations[:errors] += 1
        rescue PG::NotNullViolation => pg_not_null
          validations[:errors] += 1
        rescue ActiveRecord::RecordInvalid => invalid
          validations[:errors] += 1
          Rails.logger.error "Potential Duplicate #{period} Price Data: " +
            obj["symbol"]
        end
      end
      validations
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
