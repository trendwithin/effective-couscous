require 'mechanize'
require_relative 'data_srv_urls'
require_relative 'parse_stock_symbols'

urls = DataServer::DataServerUrls.data_server_urls
universe = []
nyse = urls[:nyse]
amex = urls[:amex]
nasdaq = urls[:nasdaq]

nyse_page = DataServer::ParseSymbols.fetch_url nyse
amex_page = DataServer::ParseSymbols.fetch_url amex
nasdaq_page = DataServer::ParseSymbols.fetch_url nasdaq

nyse_body = DataServer::ParseSymbols.parse_response_body nyse_page
amex_body = DataServer::ParseSymbols.parse_response_body amex_page
nasdaq_body = DataServer::ParseSymbols.parse_response_body nasdaq_page

nyse_data = DataServer::ParseSymbols.split_response_on_newline nyse_body
amex_data = DataServer::ParseSymbols.split_response_on_newline amex_body
nasdaq_data = DataServer::ParseSymbols.split_response_on_newline nasdaq_body

all_stock_symbols = DataServer::ParseSymbols.all_stock_symbols
prune_data = DataServer::ParseSymbols.prune_duplicates_from_source nyse_data, amex_data, nasdaq_data
prune_model_duplicates = DataServer::ParseSymbols.prune_duplicates_from_model prune_data, all_stock_symbols

format_for_insert = DataServer::ParseSymbols.gsub_colon_for_space prune_model_duplicates
# puts format_for_insert
DataServer::ParseSymbols.store_new_stocks_symbols format_for_insert
