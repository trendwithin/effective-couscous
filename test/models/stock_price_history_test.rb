require 'test_helper'

class StockPriceHistoryTest < ActiveSupport::TestCase
  include StockPriceHistoryConcern

  def setup
    @record = stock_price_histories(:one)
  end
  test 'uniqueness of record' do
    error_msg = [:market_close_date, "has already been taken"]
    dupe = @record.dup
    assert_equal false, dupe.valid?
    dupe.save
    assert_equal error_msg, dupe.errors.first
  end

  test 'valid record' do
    dupe = @record.dup
    dupe.market_close_date += 1
    assert_equal true, dupe.valid?
  end

  test 'market_close_date not nil' do
    @record.market_close_date = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'ticker not nil' do
    @record.ticker = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'open not nil' do
    @record.open = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'high not nil' do
    @record.high = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'low not nil' do
    @record.low = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'close not nil' do
    @record.close = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'last_price not nil' do
    @record.last_price = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'percent_change not nil' do
    @record.percent_change = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'net_change not nil' do
    @record.net_change = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'volume not nil' do
    @record.volume = nil
    assert_raises ActiveRecord::NotNullViolation do
      @record.save
    end
  end

  test 'most recent data point represents max value over 250 periods' do
    years_data = year_of_data
    years_data.first["volume"] = 10_000
    years_data.last["volume"]= 10_0001
    assert_equal true, find_year_high_value(years_data)
  end

  test 'most recent data point does not represent max value over 250 periods' do
    years_data = year_of_data
    years_data.first['volume'] = 10_000
    assert_equal false, find_year_high_value(years_data)
  end

  test 'midpoint represents highest data point over 250 periods' do
    years_data = year_of_data
    years_data[125]['volume'] = 10_000
    assert_equal false, find_year_high_value(years_data)
  end

  test 'pg result to array mock data check' do
    expected = 750
    result_array = pg_result_obj
    assert_equal expected, result_array.count
  end

  test 'pg result array sliced' do
    input = pg_result_obj
    expected = 3
    result = pg_result_slice input, 250
    assert_equal expected, result.count
  end
end
