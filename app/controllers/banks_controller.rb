class BanksController < ApplicationController
  before_action :set_bank, only: [:show, :edit, :update, :destroy]

  # GET /banks
  # GET /banks.json
  def index
    @banks = Bank.all
  end

  # GET /banks/1
  # GET /banks/1.json
  def show
  end

  # GET /banks/new
  def new
    @bank = Bank.new
  end

  # GET /banks/1/edit
  def edit
  end

 
  # POST /banks
  # POST /banks.json
  def create
    @bank = Bank.new(bank_params)
    @bank.user_id = current_user.id

    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    recipient = Stripe::Recipient.create(
      :name => current_user.full_name,
      :type => "individual",
      :bank_account => token
      )

    @bank.recipient_id = recipient.id

#stripe credit card payment begins
   
    
#stripe bank transfer > insert expression here:  if @challengewinner=Y, $ pushes into the user's balance summation of credit card charge amount)  #2 challenge stake+challenge stake

    current_user.save
    respond_to do |format|
      if @bank.save
        format.html { redirect_to @bank, notice: 'Bank was successfully created.' }
        format.json { render action: 'show', status: :created, location: @bank }
      else
        format.html { render action: 'new' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /banks/1
  # PATCH/PUT /banks/1.json
  def update
    respond_to do |format|
      if @bank.update(bank_params)
        format.html { redirect_to @bank, notice: 'Bank was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @bank.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /banks/1
  # DELETE /banks/1.json
  def destroy
    @bank.destroy
    respond_to do |format|
      format.html { redirect_to banks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank
      @bank = Bank.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bank_params
      params.require(:bank).permit(:bank)
    end
end
