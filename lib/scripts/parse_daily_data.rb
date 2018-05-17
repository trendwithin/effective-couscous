require 'mechanize'
require_relative 'barchart/api_connect'
require_relative 'barchart/barchart_api_parser'

# symbols = StockSymbol.limit(1).pluck(:ticker)
# symbols = ["A"]

symbols_list = StockPriceHistory.limit(2000).pluck(:ticker)

symbols_list.each_slice(100) do |symbols|
  url = "https://marketdata.websol.barchart.com/getQuote.json?apikey=" +
         ENV['barchart_api_key'] + "&symbols=#{symbols.join(',')}"


  connection = ApiConnect.new url
  connection.fetch_page
  parsed_body = connection.parse_page_response_body
  results = Barchart::BarchartApiParser.response_body_results parsed_body
  Barchart::BarchartApiParser.insert_historical_data results
end
