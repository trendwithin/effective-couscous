class AddSymbolsController < ApplicationController
  def new
  end

  def new_symbols
    @symbols = StockSymbol.today
  end

  def create
    if params[:ticker_group].empty?
      redirect_to new_add_symbol_path, notice: 'ERROR:  Input New Symbols Failed.  Please check logs.'
    else
      workflow = CreateNewSymbols.new(params[:ticker_group])
      workflow.run
      redirect_to add_symbols_new_symbols_path
    end
  end
end
