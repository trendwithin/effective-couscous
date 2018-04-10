class StockPriceHistory < ApplicationRecord
  validates_uniqueness_of :market_close_date, scope: :ticker
end
