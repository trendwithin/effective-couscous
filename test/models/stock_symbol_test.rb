require 'test_helper'

class StockSymbolTest < ActiveSupport::TestCase
  test 'returns stock symbols created today' do
    StockSymbol.create!(ticker: 'TODAY', company_name: "COMPANY")
    todays = StockSymbol.today.pluck(:ticker)
    assert_includes todays, 'TODAY'
  end

  test 'does not return stock created_at yesterday' do
    StockSymbol.create!(ticker: 'YESTERDAY', company_name: 'AYER', created_at: 1.day.ago)
    todays = StockSymbol.today.pluck(:ticker)
    refute_includes todays, 'YESTERDAY'
  end
end
