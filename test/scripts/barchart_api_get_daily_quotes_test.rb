require 'test_helper'
require 'barchart_api_parser'

module Barchart
  module BarchartApiConnect
    class BarchartApiParserGetQuoteTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('api_get_daily_quotes') do
          url = "https://marketdata.websol.barchart.com/getQuote.json?apikey=" +
                ENV['barchart_api_key'] + "&symbols=AAPL,GOOG"

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

      def test_resonse_body_returns_price_history_of_goog_and_aapl
        expected = ['AAPL', 'GOOG']
        @response_body['results'].map do |elem|
          assert_equal true, expected.include?(elem['symbol'])
        end
      end

      def test_parse_returned_api_data_format
        expected =
          {
          market_close_date: DateTime.now.strftime("%d-%m-%Y"),
          ticker: "AAPL",
          company_name: "Apple Inc",
          open: 169.88,
          high: 173.09,
          low: 169.85,
          close: 170.05,
          last_price: 170.05,
          percent_change: 0.99,
          net_change: 1.67,
          volume: 28970520
          }

        obj = {}
        @response_body['results'].map do |elem|
          obj = elem if elem['symbol'] == 'AAPL'
        end
        result = @api_connection.parse_data_from_api_response obj
        assert_equal expected, result
      end
    end
  end
end
