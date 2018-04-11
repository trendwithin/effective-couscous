require './test/test_helper'
require 'minitest/mock'
require 'barchart_api_connect'

module Barchart
  module BarchartApiConnect
    class BarchartConnectionTest < ActiveSupport::TestCase
      def setup
        @connection = Object.new
        @connection.extend(Barchart::BarchartApiConnect)
        @valid_url = 'http://example.com'
      end

      def test_no_internet_connectivity_raises_socket_error
        raises_exception = -> (a_url) { raise SocketError.new }
        @connection.stub(:fetch_url, raises_exception) do
          assert_raises SocketError do
            @connection.fetch_url @valid_url
          end
        end
      end
    end
  end
end
