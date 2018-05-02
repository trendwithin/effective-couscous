require 'test_helper'

class MarketMonitorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market_monitor = market_monitors(:one)
  end

  test "should get index" do
    get market_monitors_url
    assert_response :success
  end

  test "should get new" do
    get new_market_monitor_url
    assert_response :success
  end

  test "should create market_monitor" do
    tomorrow = Time.now + (24 * 60 * 60)
    assert_difference('MarketMonitor.count') do
      post market_monitors_url,
        params: { market_monitor:
                  { down_fifty_pct_month: @market_monitor.down_fifty_pct_month,
                    down_four_pct_daily: @market_monitor.down_four_pct_daily,
                    down_thirteen_pct_quarter: @market_monitor.down_thirteen_pct_quarter,
                    down_twenty_five_pct_month: @market_monitor.down_twenty_five_pct_month,
                    down_twenty_five_pct_quarter: @market_monitor.down_twenty_five_pct_quarter,
                    market_close_date: tomorrow,
                    notes: @market_monitor.notes,
                    up_fifty_pct_month: @market_monitor.up_fifty_pct_month,
                    up_four_pct_daily: @market_monitor.up_four_pct_daily,
                    up_thirteen_pct_quarter: @market_monitor.up_thirteen_pct_quarter,
                    up_twenty_five_pct_quarter: @market_monitor.up_twenty_five_pct_quarter,
                    up_twenty_five_pct_month: @market_monitor.up_twenty_five_pct_month,
                    total_stocks: @market_monitor.total_stocks
                  }
                }
    end

    assert_redirected_to market_monitor_url(MarketMonitor.last)
  end

  test "should show market_monitor" do
    get market_monitor_url(@market_monitor)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_monitor_url(@market_monitor)
    assert_response :success
  end

  test "should update market_monitor" do
    patch market_monitor_url(@market_monitor), params: { market_monitor: { down_fifty_pct_month: @market_monitor.down_fifty_pct_month, down_four_pct_daily: @market_monitor.down_four_pct_daily, down_thirteen_pct_quarter: @market_monitor.down_thirteen_pct_quarter, down_twenty_five_pct_month: @market_monitor.down_twenty_five_pct_month, down_twenty_five_pct_quarter: @market_monitor.down_twenty_five_pct_quarter, market_close_date: @market_monitor.market_close_date, notes: @market_monitor.notes, up_fifty_pct_month: @market_monitor.up_fifty_pct_month, up_four_pct_daily: @market_monitor.up_four_pct_daily, up_thirteen_pct_quarter: @market_monitor.up_thirteen_pct_quarter, up_twenty_five_pct_quarter: @market_monitor.up_twenty_five_pct_quarter, up_twenty_five_pct_month: @market_monitor.up_twenty_five_pct_month } }
    assert_redirected_to market_monitor_url(@market_monitor)
  end

  test "should destroy market_monitor" do
    assert_difference('MarketMonitor.count', -1) do
      delete market_monitor_url(@market_monitor)
    end

    assert_redirected_to market_monitors_url
  end
end
