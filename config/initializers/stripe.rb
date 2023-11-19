if Rails.env.production?
  Stripe.api_key = Rails.application.credentials.dig(:stripe_secret_key, :production)
  $stripe_recurring_donation_product_id = "prod_OqlLl6mR66dLVQ"
else
  Stripe.api_key = Rails.application.credentials.dig(:stripe_secret_key, :test)
  $stripe_recurring_donation_product_id = "prod_P1xUtsgjEfkGgu"
end
