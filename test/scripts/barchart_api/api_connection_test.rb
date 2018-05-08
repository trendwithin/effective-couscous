require './test/test_helper'
require 'minitest/mock'
require 'api_connect'

class ApiConnectTest < ActiveSupport::TestCase
  def setup
    valid_url = 'http://www.example.com'
    @connection = ApiConnect.new(valid_url)
  end

  def test_no_internet_connectivity_raises_socket_error
    raises_exception = -> (a_url) { raise SocketError.new }
    @connection.stub(:fetch_page_body, raises_exception) do
       assert_raises SocketError do
         @connection.fetch_page_body @valid_url
       end
    end
  end
end
