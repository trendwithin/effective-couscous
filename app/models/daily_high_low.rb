class DailyHighLow < ApplicationRecord

validates :one_month_high, presence: true, numericality: { only_integer: true }
validates :one_month_low, presence: true, numericality: { only_integer: true }
validates :three_month_high, presence: true, numericality: { only_integer: true }
validates :three_month_low, presence: true, numericality: { only_integer: true }
validates :six_month_high, presence: true, numericality: { only_integer: true }
validates :six_month_low, presence: true, numericality: { only_integer: true }
validates :fifty_two_week_high, presence: true, numericality: { only_integer: true }
validates :fifty_two_week_low, presence: true, numericality: { only_integer: true }
validates :all_time_high, presence: true, numericality: { only_integer: true }
validates :all_time_low, presence: true, numericality: { only_integer: true }
validates :year_to_date_high, presence: true, numericality: { only_integer: true }
validates :year_to_date_low, presence: true, numericality: { only_integer: true }

validates :market_close_date, presence: true
end
