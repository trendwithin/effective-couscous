class StockPriceHistory < ApplicationRecord

  validates_uniqueness_of :market_close_date, scope: :ticker

  def self.fetch_closing_data
    sql = <<~HEREDOC
      SELECT ticker, volume, market_close_date, close from (
        SELECT t.*, row_number()
        OVER (PARTITION BY ticker order by market_close_date desc)
        as rno
        FROM public.stock_price_histories t
        WHERE ticker IN (
          SELECT ticker
          FROM public.stock_price_histories
          GROUP BY ticker
          HAVING COUNT(*) > 249
        )
      ) t1
      where t1.rno <=250;
    HEREDOC
    ActiveRecord::Base.connection.execute(sql)
  end
end
