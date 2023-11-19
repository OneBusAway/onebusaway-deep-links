require 'rails_helper'

RSpec.describe "Api::V1::PaymentIntents", type: :request do
  let(:donation_amount_in_cents) { 1000 }

  describe "POST /create" do
    it "creates a new PaymentIntent" do
      allow(Stripe::PaymentIntent).to receive(:create).and_return(OpenStruct.new(client_secret: "12435"))
      post api_v1_payment_intents_path(format: "json"), params: { donation_amount_in_cents: donation_amount_in_cents }
      expect(response).to be_successful
      expect(response.body).to include("12435")
    end

    context "when there is a Stripe error" do
      before do
        allow(Stripe::PaymentIntent).to receive(:create).and_raise(Stripe::StripeError.new)
      end

      it "returns a 500 status" do
        post api_v1_payment_intents_path, params: { donation_amount_in_cents: donation_amount_in_cents }

        expect(response).to have_http_status(:internal_server_error)
      end
    end
  end
end