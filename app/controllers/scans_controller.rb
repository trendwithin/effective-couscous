class ScansController < ApplicationController
  include ScanRelatedConcerns

  def demo
    @display = []
    demo_data = StockPriceHistory.fetch_closing_data
    slice_data = split_records demo_data, 250
    slice_data.each do |elem|
      @display << elem if most_recent_record_max_high? elem, 'volume'
    end
  end
end
