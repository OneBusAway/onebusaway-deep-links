module Donations
  class OneTime < Donations::Base
    def run
      intent, error = [nil, nil]

      begin
        customer = find_or_create_customer(email, name)

        intent = Stripe::PaymentIntent.create(
          customer: customer.id,
          amount: donation_amount_in_cents,
          currency: 'usd',
          # In the latest version of the API, specifying the
          # `automatic_payment_methods` parameter is optional
          # because Stripe enables its functionality by default.
          automatic_payment_methods: { enabled: true },
          receipt_email: email
        )
      rescue Stripe::StripeError => e
        error = e
      end

      [intent, error]
    end
  end
end