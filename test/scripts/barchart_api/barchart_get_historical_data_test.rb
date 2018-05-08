require './test/test_helper'
require 'api_connect'
require 'barchart_api_parser'

module Barchart
  class GetHistoricalDataTest < ActiveSupport::TestCase
    def setup
      VCR.use_cassette('barchart_historical_data') do
        url = "https://marketdata.websol.barchart.com/getHistory.json?apikey=" +
               ENV['barchart_api_key'] + "&symbol=IBM&type=daily&startDate=20170408000000"

       @api_connection = ApiConnect.new(url)
       @page = @api_connection.fetch_page_body
       @response_body = @api_connection.parse_page_response_body
      end
    end

    def test_response_code_200
      assert_equal '200', @page.code
      assert_equal 200, @response_body['status']['code']
      assert_equal 'Success.', @response_body['status']['message']
    end

    def test_response_body_keys
      expected = ['status', 'results']
      keys = @response_body.keys
      assert_equal expected, keys
    end

    def test_full_year_data_returned
      expected = 124 # API Changed From 2-Years Data to 6-Months w No Notice
      count = @response_body['results'].count
      assert_equal expected, count
    end

    def test_parse_historical_data_from_api_response
      result = @response_body['results'].last
      format_result = Barchart::BarchartApiParser.parse_historical_data_from_api_response result
      expected =
        {
          market_close_date: "2018-05-07",
          ticker: "IBM",
          company_name: "DEFAULT",
          open: 144,
          high: 144.32,
          low: 142.64,
          close: 143.22,
          last_price: 100000,
          percent_change: 1,
          net_change: 100000,
          volume: 3657000
        }
        assert_equal expected, format_result
    end

    def test_response_body_results
      results = Barchart::BarchartApiParser.response_body_results @response_body
      assert_equal 124, results.count
    end

    def test_malformed_data_errors
      record = @response_body['results'].first
      record['open'] = nil
      malformed_record = [] << record
      result = Barchart::BarchartApiParser.insert_historical_data malformed_record, :historical
      assert_equal 1, result[:errors]
      assert_equal 0, result[:success]
    end

    def test_uniquness_violation
      record = [] << @response_body['results'].first
      duplicate = record
      Barchart::BarchartApiParser.insert_historical_data duplicate, :historical
      duplicate = Barchart::BarchartApiParser.insert_historical_data duplicate, :historical
      assert_equal 1, duplicate[:errors]
    end
  end
end
