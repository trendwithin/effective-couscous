require 'mechanize'
require_relative 'data_srv_urls'
require_relative 'parse_stock_symbols'

url = DataServer::DataServerUrls.data_server_urls
page = DataServer::ParseSymbols.fetch_url url
response_body = DataServer::ParseSymbols.parse_response_body page
new_symbols = DataServer::ParseSymbols.new_listings response_body
DataServer::ParseSymbols.store_new_stocks_symbols new_symbols
# format_response_body = DataServe::ParseSymbols.split_response_on_newline response_body
