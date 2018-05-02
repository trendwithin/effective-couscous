require "application_system_test_case"

class MarketMonitorsTest < ApplicationSystemTestCase
  test "Sumbit Form With Empty Fields Error Count" do
    visit market_monitors_url

    assert_selector "h1", text: "MARKET MONITOR"
    click_link 'New Market Monitor'
    assert_selector 'h1', text: "NEW MARKET MONITOR"

    find('input[name="commit"]').click
    assert_content '22 ERRORS PROHIBITED THIS MARKET_MONITOR FROM BEING SAVED'

  end

  test 'Submit Form With Valid Data' do
    visit new_market_monitor_url
    assert_selector 'h1', text: "NEW MARKET MONITOR"

    fill_in 'Up four pct daily', with: 20
    fill_in 'Down four pct daily', with: 10
    fill_in 'Up twenty five pct quarter', with: 30
    fill_in 'Down twenty five pct quarter', with: 2
    fill_in 'Up twenty five pct month', with: 3
    fill_in 'Down twenty five pct month', with: 1
    fill_in 'Up thirteen pct quarter', with: 5
    fill_in 'Down thirteen pct quarter', with: 3
    fill_in 'Up fifty pct month', with: 1
    fill_in 'Down fifty pct month', with: 0
    fill_in 'Total stocks', with: 3000

    find('input[name="commit"]').click
    assert_content 'Market monitor was successfully created.'
  end
end
