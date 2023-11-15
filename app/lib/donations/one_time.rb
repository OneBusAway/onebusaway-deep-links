module Donations
  class OneTime
    def initialize(donation_amount_in_cents)
      @donation_amount_in_cents = donation_amount_in_cents
    end

    def run
      intent, error = [nil, nil]

      begin
        intent = Stripe::PaymentIntent.create(
          {
            amount: @donation_amount_in_cents,
            currency: 'usd',
            # In the latest version of the API, specifying the
            # `automatic_payment_methods` parameter is optional
            # because Stripe enables its functionality by default.
            automatic_payment_methods: { enabled: true },
          }
        )
      rescue Stripe::StripeError => e
        error = e
      end

      [intent, error]
    end
  end
end