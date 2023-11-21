module Donations
  class Base

    attr_accessor :donation_amount_in_cents, :test_mode, :rails_env, :name, :email

    def initialize(params, rails_env: Rails.env)
      @donation_amount_in_cents = params['donation_amount_in_cents']
      @test_mode = params['test_mode'] == '1'
      @name = params['name']
      @email = params['email']
      @rails_env = rails_env

      Stripe.api_key = if @rails_env.production? && !@test_mode
                         Rails.application.credentials.dig(:stripe_secret_key, :production)
                       else
                         Rails.application.credentials.dig(:stripe_secret_key, :test)
                       end
    end

    def find_or_create_customer(email, name)
      find_customer_by_email(email) || Stripe::Customer.create(email:, name:)
    end

    def find_customer_by_email(email)
      Stripe::Customer.list(email:).data.first
    end

    def run
      raise NotImplementedError, "You must implement the #run method in #{self.class.name}"
    end
  end
end