class CreateNewSymbols
  attr_reader :params, :errors

  def initialize params
    @params = params
    @errors = []
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
    values = self.split_on_return
    values.each do |process|
    ticker, company_name = process.split(/\W+/)
      begin
        StockSymbol.create(ticker: ticker, company_name: company_name)
        rescue ActiveRecord::RecordNotUnique => not_unique
        @errors << ticker
        rescue PG::UniqueViolation => pgu
        @errors << ticker
      end
    end
    @errors
  end
  
end
