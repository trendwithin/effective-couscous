class ProcessHistoricalData
  attr_accessor :close_date, :company_name, :ticker
  attr_accessor :opening_price, :high_price, :low_price
  attr_accessor :closing_price, :net_change, :volume, :industry
  attr_reader :line, :format_obj

  def initialize
    @format_obj = {}
  end

  def feed_line line
    @line = line.chomp
  end

  def transform_data
    transform_line
  end

  def valid_format line
    true if line =~ /^[A-Z+]+$/
  end

  def line_to_active_record
    transform_data
    if valid_format(ticker) == true
      transform_line_to_object
      begin
        StockPriceHistory.create(format_obj)
      rescue ActiveRecord::NotNullViolation => active_record_not_null
      rescue PG::NotNullViolation => pg_not_null
      rescue ActiveRecord::RecordInvalid => invalid
      end
    end
  end

  private

  def transform_line
  @close_date, @company_name,
  @ticker, @opening_price,
  @high_price, @low_price,
  @closing_price, @volume,
  @net_change, @industry = line.split(',')
  end

  def transform_line_to_object
    format_obj[:market_close_date] = close_date.to_date
    format_obj[:ticker] = ticker
    format_obj[:company_name] = company_name
    format_obj[:open] = opening_price.to_f
    format_obj[:high] = high_price.to_f
    format_obj[:low] = low_price.to_f
    format_obj[:close] = closing_price.to_f
    format_obj[:last_price] = 100000.00
    format_obj[:percent_change] = 0.01
    format_obj[:net_change] = net_change.to_f
    format_obj[:volume] = volume
  end
end
