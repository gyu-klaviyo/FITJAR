class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /payments
  # GET /payments.json
  
  #mistook ORDER for the order "method"
  def history
    @payments = Payment.all.where(host: current_user).order("created_at DESC")
#just added, you need to show history and add a new colmn, wheter they were a host or player and show ALL history
    @payments = Payment.all.where(player: current_user).order("created_at DESC")

     
  end



  # GET /payments/new
  def new
    @payment = Payment.new
        #tells you to find the id in the URL/also in "def create"
    @challenge = Challenge.find(params[:challenge_id])
  end

  # GET /payments/1/edit
 

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)
    #tells you to find the id in the URL
    @challenge = Challenge.find(params[:challenge_id])
    @host = @challenge.user

    @payment.challenge_id = @challenge.id
    #fill in player id when you enter a new player, authenticate above, in purple
    @payment.player_id = current_user.id
    @payment.host_id = @host.id

#stripe credit card payment begins
   Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    begin
      charge = Stripe::Charge.create(
        :amount => (@challenge.stake * 100).floor,
        :currency => "usd",
        :card => token
        )
      flash[:notice] = "Thanks for ordering!"
    rescue Stripe::CardError => e
      flash[:danger] = e.message
    end
    
     current_user.recipient = authorize.id
    current_user.save
#stripe bank transfer > insert expression here:  if @challengewinner=Y, $ pushes into the user's balance summation of credit card charge amount)  #2 challenge stake+challenge stake

 transfer = Stripe::Transfer.create(
      :amount => (@challenge.stake * 95).floor,
      :currency => "usd",
      :recipient => @host.recipient
      )

    respond_to do |format|
      if @payment.save
        #redirect them to DASHBOARD
        format.html { redirect_to root_url, notice: 'Payment was successfully created.'}
        format.json { render action: 'show', status: :created, location: @payment }
      else
        format.html { render action: 'new' }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:address, :city, :state)
    end
end
