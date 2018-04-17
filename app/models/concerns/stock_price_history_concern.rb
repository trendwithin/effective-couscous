module StockPriceHistoryConcern
  extend ActiveSupport::Concern
  extend self

  def find_year_high_value data
    first_value = data.first['volume']
    last_value = data.last['volume']
    last_bool = data.max_by{ |k| k['volume'] }['volume'] == data.last['volume']
    data.pop
    first_bool = data.max_by { |k| k['volume']}['volume'] == data.first['volume']
    last_bool && first_bool
  end

  def pg_result_slice res, chunk_size
    res.each_slice(chunk_size).to_a
  end
end
