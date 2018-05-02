require 'test_helper'

class MarketMonitorTest < ActiveSupport::TestCase
  def setup
    @market_monitor = market_monitors(:one)
  end

  test 'initial state valid' do
    assert @market_monitor.valid?
  end

  test 'missing date invalid' do
    @market_monitor.market_close_date = nil
    refute @market_monitor.valid?
  end

  test 'duplicate date invalid' do
    dupe = @market_monitor.dup
    refute dupe.valid?
  end

  test 'presence of up 4pct' do
    @market_monitor.up_four_pct_daily = ''
    refute @market_monitor.valid?
  end

  test 'numericality of 4pct' do
    @market_monitor.up_four_pct_daily = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of down 4pct' do
    @market_monitor.down_four_pct_daily = ''
    refute @market_monitor.valid?
  end

  test 'numericality of down 4pct' do
    @market_monitor.down_four_pct_daily = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of up 25pct quarter' do
    @market_monitor.up_twenty_five_pct_quarter = ''
    refute @market_monitor.valid?
  end

  test 'numericality of up 25pct quarter' do
    @market_monitor.up_twenty_five_pct_quarter = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of down 25pct quarter' do
    @market_monitor.down_twenty_five_pct_quarter = ''
    refute @market_monitor.valid?
  end

  test 'numericality of down 25pct quarter' do
    @market_monitor.down_twenty_five_pct_quarter = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of up 25pct month' do
    @market_monitor.up_twenty_five_pct_month = ''
    refute @market_monitor.valid?
  end

  test 'numericality of up 25pct month' do
    @market_monitor.up_twenty_five_pct_month ='abc'
    refute @market_monitor.valid?
  end

  test 'presence of down 25pct month' do
    @market_monitor.down_twenty_five_pct_month = ''
    refute @market_monitor.valid?
  end

  test 'numericality of down 25pct month' do
    @market_monitor.down_twenty_five_pct_month ='abc'
    refute @market_monitor.valid?
  end

  test 'presence of up 13pct quater' do
    @market_monitor.up_thirteen_pct_quarter = ''
    refute @market_monitor.valid?
  end

  test 'numericality of up 13pct quarter' do
    @market_monitor.up_thirteen_pct_quarter = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of down 13pct quater' do
    @market_monitor.down_thirteen_pct_quarter = ''
    refute @market_monitor.valid?
  end

  test 'numericality of down 13pct quarter' do
    @market_monitor.down_thirteen_pct_quarter = 'abc'
    refute @market_monitor.valid?
  end

  test 'presence of up 50pct month' do
    @market_monitor.up_fifty_pct_month = ''
    refute @market_monitor.valid?
  end

  test 'numericality of up 50pct month' do
    @market_monitor.up_fifty_pct_month = 'abc'
  end

  test 'presence of down 50pct month' do
    @market_monitor.down_fifty_pct_month = ''
    refute @market_monitor.valid?
  end

  test 'numericality of down 50pct month' do
    @market_monitor.down_fifty_pct_month = 'abc'
  end

  test 'presence of total stocks' do
    @market_monitor.total_stocks = ''
    refute @market_monitor.valid?
  end

  test 'numericality of total stocks' do
    @market_monitor.total_stocks = 'abc'
  end

end
