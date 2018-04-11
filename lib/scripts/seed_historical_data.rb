require 'mechanize'
require_relative 'barchart_api_parser'

# symbols = StockSymbol.limit(1).pluck(:ticker)
symbols = ["ORCL"]
symbols.map do |symbol|
  url = "https://marketdata.websol.barchart.com/getHistory.json?apikey=" +
         ENV['barchart_api_key'] + "&symbol=#{symbol}&type=daily&startDate=20170408000000"

  page_body = Barchart::BarchartApiParser.fetch_url url
  response_body = Barchart::BarchartApiParser.parse_response_body page_body
  Barchart::BarchartApiParser.map_response_and_return_historical_record response_body

end
byebug
'test'