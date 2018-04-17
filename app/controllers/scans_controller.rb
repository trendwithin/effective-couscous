class ScansController < ApplicationController
  def demo
    @display = []
    demo_data = StockPriceHistory.fetch_closing_data
    sliced_data = StockPriceHistoryConcern.pg_result_slice demo_data, 250
    sliced_data.each do |elem|
      @display << elem.first if find_year_high_value elem
    end
  end

  def find_year_high_value data
    first_value = data.first['volume']
    last_value = data.last['volume']
    last_bool = data.max_by{ |k| k['volume'] }['volume'] == data.last['volume']
    data.pop
    first_bool = data.max_by { |k| k['volume']}['volume'] == data.first['volume']
    last_bool && first_bool
  end
end
