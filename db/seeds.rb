# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

['ONE', 'TWO', 'THREE'].map do |ins|
  250.times do |i|
    time = Time.now - ((60 * 60 * 24) * i)
    StockPriceHistory.create!(
      market_close_date: time,
      ticker: "#{ins}",
      company_name: "#{ins}CO",
      open: 9.99,
      high: 9.99,
      low: 9.99,
      close: 9.99,
      last_price: 9.99,
      percent_change: 9.99,
      net_change: 9.99,
      volume: 1
    )
  end
end
