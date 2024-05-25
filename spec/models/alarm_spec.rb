require 'rails_helper'

RSpec.describe Alarm, type: :model do
  let(:region) { create_puget_sound_region! }
  let(:message) { "The 49 bus leaves in 10 minutes" }
  let(:user_push_id) { "Push ID" }
  let(:stop_id) { "Stop ID" }
  let(:trip_id) { "Trip ID" }
  let(:service_date) { DateTime.now.to_i }
  let(:vehicle_id) { "1_123" }
  let(:stop_sequence) { "1" }

  context "with all parameters to create an alarm" do
    subject(:alarm) { region.alarms.create({ message: message,
                                             push_identifier: user_push_id,
                                             stop_id: stop_id,
                                             trip_id: trip_id,
                                             service_date: service_date,
                                             vehicle_id: vehicle_id,
                                             stop_sequence: stop_sequence })
    }
    describe "creation" do
      it "is successful" do
        expect(subject).to_not be_new_record
      end

      it "generates a secure token" do
        expect(subject.secure_token).to_not be_nil
      end
    end

    describe "#to_param" do
      it "is equal to secure_token" do
        expect(subject.to_param).to eq(subject.secure_token)
      end
    end
  end

  context "when missing the message param" do
    subject(:alarm) { region.alarms.create({ push_identifier: user_push_id,
                                             stop_id: stop_id,
                                             trip_id: trip_id,
                                             service_date: service_date,
                                             vehicle_id: vehicle_id,
                                             stop_sequence: stop_sequence })
    }
    describe "creating an alarm" do
      it "is unsuccessful" do
        expect(subject).to be_new_record
      end
    end

    describe "error messages" do
      it "mentions the missing message param" do
        expect(subject.errors.attribute_names).to eq([:message])
      end
    end
  end

  context "when missing the push_identifier param" do
    subject(:alarm) { region.alarms.create({ message: message,
                                             stop_id: stop_id,
                                             trip_id: trip_id,
                                             service_date: service_date,
                                             vehicle_id: vehicle_id,
                                             stop_sequence: stop_sequence })
    }
    describe "creating an alarm" do
      it "is unsuccessful" do
        expect(subject).to be_new_record
      end
    end

    describe "error messages" do
      it "mentions the missing push_identifier param" do
        expect(subject.errors.attribute_names).to eq([:push_identifier])
      end
    end
  end
end
