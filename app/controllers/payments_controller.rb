class PaymentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def success
  end

  def create
    @listing = Listing.find(params[:id])
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description,
        images: [@listing.image],
        amount: (@listing.price * 100).to_i,
        currency: 'aud',
        quantity: @listing.quantity
      }],
      payment_intent_data: {
        metadata: {
          listing_id: @listing.id
        }
      },
      success_url: "#{root_url}payments/success?eventId=#{@listing.id}",
      cancel_url: "#{root_url}"
    )
    render json: { id: session.id }
  end

  def webhook
    endpoint_secret = Rails.application.credentials[Rails.env.to_sym][:stripe][:endpoint_secret]
    begin
      sig_header = request.env['HTTP_STRIPE_SIGNATURE']
      payload = request.body.read
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      # Invalid payload
      return status 400
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      return status 400
    end
    case event['type']  
    when 'checkout.session.completed'
      checkout_session = event['data']['object']

      # Save an order in your database, marked as 'awaiting payment'
      # create_order(checkout_session)

      # Check if the order is already paid (e.g., from a card payment)
      #
      # A delayed notification payment will have an `unpaid` status, as
      # you're still waiting for funds to be transferred from the customer's
      # account.
      if checkout_session.payment_status == 'paid'
        # fulfill_order(checkout_session)
      end
    when 'checkout.session.async_payment_succeeded'
      checkout_session = event['data']['object']

      # Fulfill the purchase...
      # fulfill_order(checkout_session)
    when 'checkout.session.async_payment_failed'
      session = event['data']['object']

      # Send an email to the customer asking them to retry their order
      # email_customer_about_failed_payment(checkout_session)
    end
  end
end
