require './test/test_helper'
require 'json'
require 'barchart_api_connect'

module Barchart
  module BarchartApiConnect
    class BarchartConnectionErrorTest < ActiveSupport::TestCase
      def test_invalid_url_raises_mechanize_response_code_error
        VCR.use_cassette('connection_error') do
          @url = 'http://www.trendwithin.com/nopage'
          @data_parser = Object.new
          @data_parser.extend(Barchart::BarchartApiConnect)
          assert_raises Mechanize::ResponseCodeError do
            @data_parser.fetch_url(@url, 1)
          end
        end
      end
    end
  end
end
