class CreateNewSymbols
  attr_reader :params

  def initialize params
    @params = params
  end

  def valid_data_format?
    true if params.match(/^[[:alpha:][:blank:]]+$/)
  end

  def params_to_array
    params.split(/\W+/)
  end

  def split_on_return
    params.split(/\r?\n/)
  end

  def run
    StockSymbol.transaction do
      values = self.split_on_return
      values.each do |process|
        ticker, company_name = process.split(/\W+/)
        StockSymbol.create(ticker: ticker, company_name: company_name)
      end
    end
  end
end
