require 'mechanize'
require_relative 'barchart_api_connect'
require_relative 'barchart_api_parser'

# symbols = StockSymbol.limit(1).pluck(:ticker)
# symbols = ["A"]
symbols_list = StockSymbol.limit(2000).pluck(:ticker)
symbols_list.each_slice(100) do |symbols|
  url = "https://marketdata.websol.barchart.com/getQuote.json?apikey=" +
         ENV['barchart_api_key'] + "&symbols=#{symbols.join(',')}"
  page_body = Barchart::BarchartApiConnect.fetch_url url
  response_body = Barchart::BarchartApiConnect.parse_response_body page_body
  Barchart::BarchartApiParser.map_response_and_return_formatted_record response_body
end
