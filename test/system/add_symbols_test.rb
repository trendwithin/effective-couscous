require "application_system_test_case"

class AddSymbosTest < ApplicationSystemTestCase

  test 'Empty Sumbit Value Errs Out' do
    visit new_add_symbol_path
    assert_selector 'h1', text: 'NEW ADD SYMBOL'

    find('input[name="commit"]').click
    assert_content 'ERROR:  Input New Symbols Failed.  Please check logs.'
  end

  test 'Comma Separated Values Entered' do
    visit new_add_symbol_path
    fill_in 'ticker_group', with: "ABCD Alpha Beta\r\nWXYZ Win Xi Yi Zee"
    find('input[name="commit"]').click
    assert_content 'ABCD'
    assert_content 'WXYZ'
  end
end
