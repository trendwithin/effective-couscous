require 'test_helper'
require 'barchart_api_parser'
module Barchart
  module BarchartApiConnect
    class BarchartAGetChunkedDailyQuote < ActiveSupport::TestCase
      def setup
        @data = one_hundred_symbols
        chunked = @data.each_slice(100).to_a
        symbols = chunked.join(',')
        VCR.use_cassette('daily_data_requrest') do
          url = "https://marketdata.websol.barchart.com/getQuote.json?apikey=" +
                ENV['barchart_api_key'] + "&symbols=#{symbols}"
          @api_connection = Object.new
          @api_connection.extend(Barchart::BarchartApiParser)
          @page = @api_connection.fetch_url url
          @response_body = @api_connection.parse_response_body(@page)
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

      def test_one_hundred_records_returned
        expected = 100
        count = @response_body['results'].count
        assert_equal expected, count
      end

      def test_malformed_record_returns_error
        record = @response_body['results'].first
        parsed = @api_connection.parse_data_from_api_response record
        parsed[:open] = nil
        assert_raises ActiveRecord::NotNullViolation do
          StockPriceHistory.create!(parsed)
        end
      end

      def test_malformed_record_returns_error_count
        results = @api_connection.map_response_and_return_formatted_record @response_body
        assert_equal 8, results[:errors]
        assert_equal 92, results[:success]
      end
    end
  end
end
