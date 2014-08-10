class ChargesController < ApplicationController
  before_action :authenticate_user!

	def new
	@charge = Charge.new
	@challenge = Challenge.find(params[:challenge_id])
	end

	def create
	  # Amount in cents
	 @amount = calc

	 
	 #@challenge = Challenge.new(challenge_params)
	 
	  customer = Stripe::Customer.create(
	    :email => 'jackson@thevicejar.com',
	    :card  => params[:stripeToken]
	  )

	  charge = Stripe::Charge.create(
	    :customer    => customer.id,
	    :amount      => @amount,
	    :description => 'Rails Stripe customer',
	    :currency    => 'usd'
	  )

    #current_user.update_attribute(:extra_access, true)
   #redirect_to challenge_path+challenge_id

		rescue Stripe::CardError => e
		  flash[:error] = e.message
		  redirect_to charges_path
	

	end
    

	def calc
	@amount = (Challenge.find(61).stake * 100).floor
	end
  



#stripe credit card payment begins

#stripe bank transfer > insert expression here:  if @challengewinner=Y, $ pushes into the user's balance summation of credit card charge amount)  #2 challenge stake+challenge stake

  


    
end
