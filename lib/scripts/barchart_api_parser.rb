require 'mechanize'
require 'json'

module Barchart
  module BarchartApiParser
    extend self

    def fetch_url url, max_attempts = 5
      tries ||= 0
      Mechanize.new.get url
      rescue SocketError => se
        if (tries += 1) <= max_attempts
          retry
        else
          raise se
        end
      rescue Mechanize::ResponseCodeError => rce
        if (tries += 1) <= max_attempts
          retry
        else
          raise rce
        end
    end

    def parse_response_body page
      JSON.parse(page.body)
    end

    def parse_data_from_api_response obj
      format_obj = {}
      format_obj[:ticker] = obj['symbol']
      format_obj[:name] = obj['name']
      format_obj[:open] = obj['open']
      format_obj[:high] = obj['high']
      format_obj[:low] = obj['low']
      format_obj[:close] = obj['close']
      format_obj[:lastPrice] = obj['lastPrice']
      format_obj[:percentChange] = obj['percentChange']
      format_obj[:netChange] = obj['netChange']
      format_obj[:volume] = obj['volume']
      format_obj
    end
  end
end
