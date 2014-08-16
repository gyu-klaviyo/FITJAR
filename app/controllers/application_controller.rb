class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def cash
    Stripe.api_key = ENV["STRIPE_API_KEY"]
    token = params[:stripeToken]

    recipient = Stripe::Recipient.create(
      :name => current_user.full_name,
      :type => "individual",
      :bank_account => token
      )

    current_user.recipient = recipient.id
    current_user.save
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :user_name
    devise_parameter_sanitizer.for(:account_update) << :first_name
    devise_parameter_sanitizer.for(:account_update) << :last_name
    devise_parameter_sanitizer.for(:account_update) << :user_name
    devise_parameter_sanitizer.for(:account_update) << :avatar
    devise_parameter_sanitizer.for(:account_update) << :gender
    devise_parameter_sanitizer.for(:account_update) << :height
    devise_parameter_sanitizer.for(:account_update) << :weight
    devise_parameter_sanitizer.for(:account_update) << :activity
  end
end

