class MarketMonitorsController < ApplicationController
  before_action :set_market_monitor, only: [:show, :edit, :update, :destroy]

  # GET /market_monitors
  # GET /market_monitors.json
  def index
    @market_monitors = MarketMonitor.all
  end

  # GET /market_monitors/1
  # GET /market_monitors/1.json
  def show
  end

  # GET /market_monitors/new
  def new
    @market_monitor = MarketMonitor.new
  end

  # GET /market_monitors/1/edit
  def edit
  end

  # POST /market_monitors
  # POST /market_monitors.json
  def create
    @market_monitor = MarketMonitor.new(market_monitor_params)

    respond_to do |format|
      if @market_monitor.save
        format.html { redirect_to @market_monitor, notice: 'Market monitor was successfully created.' }
        format.json { render :show, status: :created, location: @market_monitor }
      else
        format.html { render :new }
        format.json { render json: @market_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /market_monitors/1
  # PATCH/PUT /market_monitors/1.json
  def update
    respond_to do |format|
      if @market_monitor.update(market_monitor_params)
        format.html { redirect_to @market_monitor, notice: 'Market monitor was successfully updated.' }
        format.json { render :show, status: :ok, location: @market_monitor }
      else
        format.html { render :edit }
        format.json { render json: @market_monitor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /market_monitors/1
  # DELETE /market_monitors/1.json
  def destroy
    @market_monitor.destroy
    respond_to do |format|
      format.html { redirect_to market_monitors_url, notice: 'Market monitor was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_monitor
      @market_monitor = MarketMonitor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def market_monitor_params
      params.require(:market_monitor).permit(:market_close_date, :up_four_pct_daily,
                                             :down_four_pct_daily, :up_twenty_five_pct_quarter,
                                             :down_twenty_five_pct_quarter, :up_twenty_five_pct_month,
                                             :down_twenty_five_pct_month, :up_thirteen_pct_quarter,
                                             :down_thirteen_pct_quarter, :up_fifty_pct_month,
                                             :down_fifty_pct_month, :total_stocks, :notes)
    end
end
