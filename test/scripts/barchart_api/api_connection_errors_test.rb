require './test/test_helper'
require 'json'
require 'api_connect'

class ApiConnectionErrorsTest < ActiveSupport::TestCase
  def test_invalid_url_raises_mechanize_response_code_error
    VCR.use_cassette('connection_error') do
      @url = 'http://www.trendwithin.com/nopage'
      @data_parser = ApiConnect.new(@url)
      assert_raises Mechanize::ResponseCodeError do
        @data_parser.fetch_page_body(1)
      end
    end
  end
end
