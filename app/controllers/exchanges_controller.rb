class ExchangesController < ApplicationController
  before_action :authenticate_user!

  # GET /exchanges or /exchanges.json
  def index
    # @exchanges = Exchange.all
    @category = current_user.categories.find(params[:category_id])
    @exchanges = @category.exchanges.order(created_at: :desc)
  end

  # GET /exchanges/1 or /exchanges/1.json
  def show; end

  # GET /exchanges/new
  def new
    @category = current_user.categories.find(params[:category_id])
    @categories = Category.where(user_id: current_user.id)
    @exchange = Exchange.new
  end

  # GET /exchanges/1/edit
  def edit; end

  # POST /exchanges or /exchanges.json
  def create
    @exchange = current_user.exchanges.build(exchange_params)
    @category = current_user.categories.find(params[:category_id])

    if @exchange.save
      # Category successfully created
      flash[:notice] = 'Transaction created successfully.'
      redirect_to user_category_exchanges_path(current_user, @category)
    else
      # Handle validation errors
      flash[:notice] = 'Transaction not created successfully.'
      render :new
    end
  end

  # PATCH/PUT /exchanges/1 or /exchanges/1.json
  def update
    respond_to do |format|
      if @exchange.update(exchange_params)
        format.html { redirect_to exchange_url(@exchange), notice: 'Exchange was successfully updated.' }
        format.json { render :show, status: :ok, location: @exchange }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @exchange.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /exchanges/1 or /exchanges/1.json
  def destroy
    @exchange.destroy

    respond_to do |format|
      format.html { redirect_to exchanges_url, notice: 'Exchange was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_exchange
    @exchange = Exchange.find(params[:id])
  end

  # Only allow a list of trusted parameters through.

  def exchange_params
    params.require(:exchange).permit(:name, :amount, category_ids: [])
  end
end
