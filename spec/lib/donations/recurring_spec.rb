require 'rails_helper'

describe "Donations::Recurring" do
  let(:valid_params) do
    {
      'donation_amount_in_cents' => '500',
      'test_mode' => '1',
      'name' => 'Test User',
      'email' => 'test@example.com'
    }
  end
  describe '#initialize' do
    it 'sets the donation amount' do
      donation = Donations::Recurring.new(valid_params)
      expect(donation.donation_amount_in_cents).to eq('500')
    end
  end

  describe '#run' do
    before do
      allow(Stripe::Customer).to receive(:create).and_return(double('Customer', id: 'cus_test'))
      allow(Stripe::Customer).to receive(:list).and_return(double('Customer', data: []))
      allow(Stripe::EphemeralKey).to receive(:create).and_return(double('EphemeralKey'))
      allow_any_instance_of(Donations::Recurring).to receive(:create_subscription).and_return(double('Subscription'))
    end

    it 'creates a new Stripe customer' do
      donation = Donations::Recurring.new(valid_params)
      donation.run
      expect(Stripe::Customer).to have_received(:create)
    end

    it 'creates a new Stripe ephemeral key' do
      donation = Donations::Recurring.new(valid_params)
      donation.run
      expect(Stripe::EphemeralKey).to have_received(:create)
    end

    it 'creates or finds a subscription' do
      donation = Donations::Recurring.new(valid_params)
      donation.run
      expect(donation).to have_received(:create_subscription)
    end
  end

  describe '#create_subscription' do
    before do
      allow(Stripe::Price).to receive(:create).and_return(double('Price', id: 'price_test'))
      allow(Stripe::Subscription).to receive(:create).and_return(double('Subscription'))
    end

    it 'creates a new Stripe price' do
      donation = Donations::Recurring.new(valid_params)
      donation.send(:create_subscription, 'cus_test')
      expect(Stripe::Price).to have_received(:create)
    end

    it 'creates a new Stripe subscription' do
      donation = Donations::Recurring.new(valid_params)
      donation.send(:create_subscription, 'cus_test')
      expect(Stripe::Subscription).to have_received(:create)
    end
  end
end