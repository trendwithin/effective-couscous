module StockPriceHistoryConcern
  include ActiveSupport::Concern
  
  def find_year_high_value data
    first_value = data.first['volume']
    last_value = data.last['volume']
    last_bool = data.max_by{ |k| k['volume'] }['volume'] == data.last['volume']
    data.pop
    first_bool = data.max_by { |k| k['volume']}['volume'] == data.first['volume']
    last_bool && first_bool
  end
end
