require './test/test_helper'
require 'barchart_api_connect'

module Barchart
  module BarchartApiConnect
    class BarchartApiConnectionTest < ActiveSupport::TestCase
      def setup
        VCR.use_cassette('api_connection_verification') do
          url = "https://marketdata.websol.barchart.com/getHistory.json?apikey=" +
                 ENV['barchart_api_key'] + "&symbol=IBM&type=daily&startDate=20170408000000"

          @api_connection = Object.new
          @api_connection.extend(Barchart::BarchartApiConnect)
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
    end
  end
end
