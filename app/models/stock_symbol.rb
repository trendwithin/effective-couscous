class StockSymbol < ApplicationRecord
  validates :ticker, presence: true

  def self.today
    where("created_at >= ?", Time.zone.now.beginning_of_day)
  end
end
