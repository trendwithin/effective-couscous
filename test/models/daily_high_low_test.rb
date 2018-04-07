require 'test_helper'

class DailyHighLowTest < ActiveSupport::TestCase
  def setup
    current_date = DateTime.now.strftime("%d-%m-%Y")
    @record = DailyHighLow.new(
      one_month_high: 1,
      one_month_low: 1,
      three_month_high: 1,
      three_month_low: 1,
      six_month_high: 1,
      six_month_low: 1,
      fifty_two_week_high: 1,
      fifty_two_week_low: 1,
      all_time_high: 1,
      all_time_low: 1,
      year_to_date_high: 1,
      year_to_date_low: 1,
      market_close_date: current_date)
  end

  def test_valid_record
    assert_equal true, @record.valid?
  end

  def test_missing_market_close_date_invalidates_record
    @record.market_close_date = nil
    assert_equal false, @record.valid?
  end

  def test_nil_one_month_high_invalidates_record
    @record.one_month_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_one_month_low_invalidates_record
    @record.one_month_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_one_month_high_invalidates_record
    @record.one_month_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_one_month_low_invalidates_record
    @record.one_month_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_one_month_high_invalidates_record
    @record.one_month_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_one_month_low_invalidates_record
    @record.one_month_low = 'abc'
    assert_equal false, @record.valid?
  end

  def test_nil_three_month_high_invalidates_record
    @record.three_month_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_three_month_low_invalidates_record
    @record.three_month_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_three_month_high_invalidates_record
    @record.three_month_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_three_month_low_invalidates_record
    @record.three_month_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_three_month_high_invalidates_record
    @record.three_month_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_three_month_low_invalidates_record
    @record.three_month_low = 'abc'
    assert_equal false, @record.valid?
  end

  def test_nil_six_month_high_invalidates_record
    @record.six_month_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_six_month_low_invalidates_record
    @record.six_month_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_six_month_high_invalidates_record
    @record.six_month_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_six_month_low_invalidates_record
    @record.six_month_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_six_month_high_invalidates_record
    @record.six_month_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_six_month_low_invalidates_record
    @record.six_month_low = 'abc'
    assert_equal false, @record.valid?
  end

  def test_nil_fifty_two_week_high_invalidates_record
    @record.fifty_two_week_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_fifty_two_week_low_invalidates_record
    @record.fifty_two_week_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_fifty_two_week_high_invalidates_record
    @record.fifty_two_week_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_fifty_two_week_low_invalidates_record
    @record.fifty_two_week_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_fifty_two_week_high_invalidates_record
    @record.fifty_two_week_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_fifty_two_week_low_invalidates_record
    @record.fifty_two_week_low = 'abc'
    assert_equal false, @record.valid?
  end

  def test_nil_all_time_high_invalidates_record
    @record.all_time_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_all_time_low_invalidates_record
    @record.all_time_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_all_time_high_invalidates_record
    @record.all_time_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_all_time_low_invalidates_record
    @record.all_time_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_all_time_high_invalidates_record
    @record.all_time_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_all_time_low_invalidates_record
    @record.all_time_low = 'abc'
    assert_equal false, @record.valid?
  end

  def test_nil_year_to_date_high_invalidates_record
    @record.year_to_date_high = nil
    assert_equal false, @record.valid?
  end

  def test_nil_year_to_date_low_invalidates_record
    @record.year_to_date_low = nil
    assert_equal false, @record.valid?
  end

  def test_empty_year_to_date_high_invalidates_record
    @record.year_to_date_high = ' '
    assert_equal false, @record.valid?
  end

  def test_empty_year_to_date_low_invalidates_record
    @record.year_to_date_low = ' '
    assert_equal false, @record.valid?
  end

  def test_alpha_year_to_date_high_invalidates_record
    @record.year_to_date_high = 'abc'
    assert_equal false, @record.valid?
  end

  def test_alpha_year_to_date_low_invalidates_record
    @record.year_to_date_low = 'abc'
    assert_equal false, @record.valid?
  end
end
