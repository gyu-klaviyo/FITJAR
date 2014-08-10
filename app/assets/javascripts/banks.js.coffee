jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  bank.setupForm()

bank =
  setupForm: ->
    $('#new_bank').submit ->
      if $('input').length > 6
        $('input[type=submit]').attr('disabled', true)
        Stripe.bankAccount.createToken($('#new_bank'), bank.handleStripeResponse)
        false

  handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_bank').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_bank')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)