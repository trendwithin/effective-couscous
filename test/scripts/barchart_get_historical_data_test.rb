require 'test_helper'
require 'barchart_api_parser'
module Barchart
  module BarchartApiParser
    class BarchartApiParserHistoricalDataTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('barchart_historical_data') do
          url = "https://marketdata.websol.barchart.com/getHistory.json?apikey=" +
                 ENV['barchart_api_key'] + "&symbol=IBM&type=daily&startDate=20170408000000"

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

      def test_full_year_data_returned
        expected = 252
        count = @response_body['results'].count
        assert_equal expected, count
      end

      # nb: Descrepency between daily/historical api return
      def test_parse_historical_data_from_api_response
        result = @response_body['results'].last
        format_result = @api_connection.parse_historical_data_from_api_response result
        expected =
          {
            market_close_date: DateTime.now.strftime("%d-%m-%Y"),
            ticker: "IBM",
            company_name: "DEFAULT",
            open: 155.03,
            high: 156.605,
            low: 154.75,
            close: 155.39,
            last_price: 100000,
            percent_change: 1,
            net_change: 100000,
            volume: 3955900
          }
          assert_equal expected, format_result
      end
    end
  end
end
