jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  challenge.setupForm()

challenge =
  setupForm: ->
    $('#new_challenge').submit ->
    if $('input').length > 6
          $('input[type=submit]').attr('disabled', true)
          Stripe.bankAccount.createToken($('#new_challenge'), challenge.handleStripeResponse)
          false

   handleStripeResponse: (status, response) ->
    if status == 200
      $('#new_challenge').append($('<input type="hidden" name="stripeToken" />').val(response.id))
      $('#new_challenge')[0].submit()
    else
      $('#stripe_error').text(response.error.message).show()
      $('input[type=submit]').attr('disabled', false)