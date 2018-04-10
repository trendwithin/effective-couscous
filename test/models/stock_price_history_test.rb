require 'test_helper'

class StockPriceHistoryTest < ActiveSupport::TestCase
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
end
