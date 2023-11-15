Stripe.api_key = if Rails.env.production?
                   Rails.application.credentials.dig(:stripe_secret_key, :production)
                 else
                   Rails.application.credentials.dig(:stripe_secret_key, :test)
                 end
