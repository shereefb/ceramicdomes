# Set your secret key. Remember to switch to your live secret key in production!
# See your keys here: https://dashboard.stripe.com/account/apikeys


require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'json'
require 'stripe'

Stripe.api_key = 'sk_test_51Hvrq6FL3dvoEEzNMONG5pJfaWdk1ApKrlbZnqusrJe4T5gjiiy4JF19mF8XHZihxEgyq13dyZmHVgcgZMbfOg7Q00fe7QEUtn'

# Stripe.api_key = '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'

get '/' do
    File.read(File.join('public', 'index.html'))
end


post '/create-checkout-session' do
  session = Stripe::Checkout::Session.create({
    payment_method_types: ['card'],
    line_items: [{
      price_data: {
        currency: 'usd',
        product_data: {
          name: 'Zome Pre-order',
          description: 'Reserve your spot in our productin line. Right now, we are shipping orders 6 weeks out. Once you pre-order, we will be in touch within 48 hours to schedule production and delivery. Pre-orders are fully refundable.' ,
          images: ['http://zomes.com/public/images/uploads/hires/R1_1.jpg']
        },
        unit_amount: 100000,
      },
      quantity: 1,
    }],
    mode: 'payment',
    # For now leave these URLs as placeholder values.
    #
    # Later on in the guide, you'll create a real success page, but no need to
    # do it yet.
    success_url: 'http://zomes.com/public/success.html',
    cancel_url: 'http://zomes.com/#pricing-table7',
  })

  { id: session.id }.to_json
end
#