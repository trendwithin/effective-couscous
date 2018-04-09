class StockSymbol < ApplicationRecord
  validates :ticker, presence: true
end
