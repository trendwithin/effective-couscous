class ScansController < ApplicationController
  include ScanRelatedConcerns

  def demo
    @years_highest_volume = []
    @years_highest_close = []
    demo_data = StockPriceHistory.fetch_closing_data
    slice_data = split_records demo_data, 250
    slice_data.each do |elem|
      @years_highest_volume << elem.first['ticker'] if most_recent_record_max_high? elem, 'volume'
      @years_highest_close  << elem.first['ticker'] if most_recent_record_max_high? elem, 'close'
    end
  end
end
