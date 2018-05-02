class MarketMonitor < ApplicationRecord
  validates :market_close_date, presence: true, uniqueness: true
  validates :up_four_pct_daily, presence: true, numericality: { only_integer: true}
  validates :down_four_pct_daily, presence: true, numericality: { only_integer: true}
  validates :up_twenty_five_pct_quarter, presence: true, numericality: { only_integer: true}
  validates :down_twenty_five_pct_quarter, presence: true, numericality: { only_integer: true}
  validates :up_twenty_five_pct_month, presence: true, numericality: { only_integer: true }
  validates :down_twenty_five_pct_month, presence: true, numericality: { only_integer: true}
  validates :up_thirteen_pct_quarter, presence: true, numericality: { only_integer: true }
  validates :down_thirteen_pct_quarter, presence: true, numericality: { only_integer: true}
  validates :up_fifty_pct_month, presence: true, numericality: { only_integer: true }
  validates :down_fifty_pct_month, presence: true, numericality: { only_integer: true }
  validates :total_stocks, presence: true, numericality: { only_integer: true }

end
