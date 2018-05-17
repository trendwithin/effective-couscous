require 'csv'

namespace :db do
  namespace :seed_historical_data do
    desc 'Import Historical Stock Data'

    task import_historical_data: :environment do
      filename = File.join(Rails.root, 'db', 'data_files', 'stock_import_2018.txt')
      test_file = File.join(Rails.root, 'test', 'lib', 'test_data' '2018.txt')

      filename = test_file if Rails.env.test?
      @process = ProcessHistoricalData.new
      File.open(filename, 'r') do |f|
         f.each_with_index do |line, index|
           @process.feed_line line
           @process.line_to_active_record
         end
      end
    end
  end
end
