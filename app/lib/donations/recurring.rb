
module Donations
  class Recurring
    def initialize(donation_amount_in_cents)
      @donation_amount_in_cents = donation_amount_in_cents
    end

    def run
      recurring_response = RecurringResponse.new(@donation_amount_in_cents)

      begin
        customer = Stripe::Customer.create()
        recurring_response.customer_id = customer.id

        recurring_response.ephemeral_key = Stripe::EphemeralKey.create(
          {customer: recurring_response.customer_id},
          {stripe_version: '2023-08-16'}
        )
        recurring_response.subscription = create_subscription(recurring_response.customer_id)
      rescue Stripe::StripeError => e
        recurring_response.error = e
      end

      recurring_response
    end

    private

    def create_subscription(customer_id)
      # Create a new price for the custom donation amount
      price = Stripe::Price.create(
        unit_amount: @donation_amount_in_cents,
        currency: 'usd',
        recurring: { interval: 'month' },
        product: $stripe_recurring_donation_product_id,
        )

      # Create or update the subscription with the new price
      subscription = Stripe::Subscription.create(
        customer: customer_id,
        items: [{ price: price.id }],
        payment_behavior: 'default_incomplete',
        expand: ['latest_invoice.payment_intent'],
        )

      subscription
    end
  end

  class RecurringResponse
    attr_accessor :donation_amount_in_cents, :subscription, :ephemeral_key, :error, :customer_id

    def initialize(donation_amount_in_cents)
      @donation_amount_in_cents = donation_amount_in_cents
    end
  end
end