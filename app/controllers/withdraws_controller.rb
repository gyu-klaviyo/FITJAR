class WithdrawsController < ApplicationController
  before_action :set_withdraw, only: [:show, :edit, :update, :destroy]

  # GET /withdraws
  # GET /withdraws.json
  def index
    @withdraws = Withdraw.all
  end

  # GET /withdraws/1
  # GET /withdraws/1.json
  def show
  end

  # GET /withdraws/new
  def new
    @withdraw = Withdraw.new
    @bank = Bank.find(params[:bank_id])
  end

  # GET /withdraws/1/edit
  def edit
  end
  
  
  # POST /withdraws
  # POST /withdraws.json
  def create
    @withdraw = Withdraw.new(withdraw_params)
    #@withdraw = current_user.id
    @bank = Bank.find(params[:bank_id])
    @withdraw.bank_id = @bank.id

   Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    
#stripe bank transfer > insert expression here:  if @challengewinner=Y, $ pushes into the user's balance summation of credit card charge amount)  #2 challenge stake+challenge stake

 transfer = Stripe::Transfer.create(
      :amount => 500000,
      :currency => "usd",
      :recipient => @bank.recipient_id
      )

    @withdraw.user_id = current_user.id

#stripe credit card payment begins
  

    respond_to do |format|
      if @withdraw.save
        format.html { redirect_to @bank, notice: 'Withdraw was successfully created.' }
        format.json { render action: 'show', status: :created, location: @withdraw }
      else
        format.html { render action: 'new' }
        format.json { render json: @withdraw.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdraws/1
  # PATCH/PUT /withdraws/1.json
  def update
    respond_to do |format|
      if @withdraw.update(withdraw_params)
        format.html { redirect_to @withdraw, notice: 'Withdraw was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @withdraw.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdraws/1
  # DELETE /withdraws/1.json
  def destroy
    @withdraw.destroy
    respond_to do |format|
      format.html { redirect_to withdraws_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdraw
      @withdraw = Withdraw.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def withdraw_params
      params.require(:withdraw).permit(:amount)
    end
end
