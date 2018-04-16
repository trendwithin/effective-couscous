class ScansController < ApplicationController
  def demo
    @demo_data = StockPriceHistory.fetch_closing_data
  end
end
