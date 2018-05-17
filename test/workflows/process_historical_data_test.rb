require 'test_helper'

class ProcessHistoricalDataTest < ActiveSupport::TestCase
  setup do
    @process = ProcessHistoricalData.new
    @valid_data_format =
      "20180510,Agilent Technologies Inc,A,68.12,68.84,68.12,68.84,5634,0.71,"\
      "HEALTH SERVICES - Medical Laboratories & Research\r\n"

    @invalid_data_format = <<~HEREDOC
      20160307,NASDAQ Short Term Trade Index,$TRINQ,0.78,1.39,0.77,1.28,0,0.25,\r
    HEREDOC
  end

  test '#transform_data' do
    @process.feed_line @valid_data_format
    @process.transform_data
    assert_equal "A", @process.ticker
  end

  test '#validate_format true' do
    data = "ABC"
    result = @process.valid_format data
    assert_equal true, result
  end

  test '#validate_format false' do
    data = "$TICK"
    result = @process.valid_format data
    assert_nil result
  end

  test '#line_to_active_record creates valid AR' do
    @process.feed_line @valid_data_format
    assert_difference 'StockPriceHistory.count' do
      @process.line_to_active_record
    end
  end

  test '#line_to_active_record: does not create AR' do
    @process.feed_line @invalid_data_format
    @process.line_to_active_record
    assert_difference 'StockPriceHistory.count', 0 do
      @process.line_to_active_record
    end
    assert @process.format_obj == {}
  end
end
