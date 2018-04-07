require_relative 'url_list'
require_relative 'barchart'

# Dev Mode Script
record = DailyHighLow.new
record.market_close_date = Time.now
Barchart::BarchartUrls.barchart_urls.each do |key, value|
  page = Barchart::BarchartDataParser.fetch_url value
  response_body = Barchart::BarchartDataParser.parse_response_body page
  count = Barchart::BarchartDataParser.parse_total response_body
  record[key] = count
end

puts record.valid?
