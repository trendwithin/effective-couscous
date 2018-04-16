ENV['RAILS_ENV'] ||= 'test'
$LOAD_PATH << File.expand_path('lib/scripts')
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'webmock/minitest'
require 'vcr'
require 'rake'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = 'test/cassettes/vcr_cassettes'
    config.hook_into :webmock

    config.filter_sensitive_data("<REDACTED>") do
      ENV['barchart_api_key']
    end
  end

  # Add more helper methods to be used by all tests here...
  def one_hundred_symbols
    ["A", "AA", "AAC", "AAN", "AAP", "AAT", "AAV", "AB", "ABB", "ABBV", "ABC", "ABEV", "ABG",
     "ABM", "ABR", "ABR-A", "ABR-B", "ABR-C", "ABRN", "ABT", "ABX", "AC", "ACC", "ACCO", "ACH",
     "ACM", "ACN", "ACP", "ACRE", "ACV", "ADC", "ADM", "ADNT", "ADS", "ADSW", "ADT", "ADX", "AEB",
     "AED", "AEE", "AEG", "AEH", "AEK", "AEL", "AEM", "AEO", "AEP", "AER", "AES", "AET", "AEUA",
     "AFB", "AFC", "AFG", "AFGE", "AFGH", "AFI", "AFL", "AFS-A", "AFS-B", "AFS-C", "AFS-D", "AFS-E",
     "AFS-F", "AFSS", "AFST", "AFT", "AG", "AGC", "AGCO", "AGD", "AGI", "AGM", "AGM-A", "AGM-B",
     "AGM-C", "AGM.A", "AGN", "AGN-A", "AGO", "AGO-B", "AGO-E", "AGO-F", "AGR", "AGRO", "AGS", "AGX",
     "AHC", "AHH", "AHL", "AHL-C", "AHL-D", "AHP", "AHP-B", "AHT", "AHT-D", "BKE", "AHT-F", "AHT-G",
     "AHT-H"]
  end

  def year_of_data
    data = []
    250.times do |elem|
      volume = rand(1..100)
      market_close_date = (DateTime.now - elem).strftime("%Y-%m-%d")
      close = rand(10..25)

      data << {
        "ticker"=>"TESTER",
        "volume"=> volume,
        "market_close_date"=> market_close_date,
        close: close
      }
    end
    data.reverse
  end
end
