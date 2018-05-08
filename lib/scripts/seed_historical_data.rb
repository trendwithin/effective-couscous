require 'mechanize'
# require_relative 'barchart_api_connect'
# require_relative 'barchart_api_parser'

require_relative 'barchart/api_connect'
require_relative 'barchart/barchart_api_parser'

# symbols = StockSymbol.limit(1).pluck(:ticker)
# symbols = ["A"]
symbols = StockSymbol.limit(2).to_a
symbols.map do |symbol|
  url = "https://marketdata.websol.barchart.com/getHistory.json?apikey=" +
         ENV['barchart_api_key'] + "&symbol=#{symbol.ticker}&type=daily&startDate=20170408000000"

connection = ApiConnect.new url
connection.fetch_page
parsed_body = connection.parse_page_response_body
results = Barchart::BarchartApiParser.response_body_results parsed_body
Barchart::BarchartApiParser.insert_historical_data results, :historical
end
