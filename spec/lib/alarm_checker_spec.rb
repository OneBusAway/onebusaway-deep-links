require 'rails_helper'

RSpec.describe AlarmChecker do
  context "in the Puget Sound region, with 300 seconds until departure, and a valid push identifier" do
    let(:region) { create_puget_sound_region! }

    context "with a departure 300 seconds in the future" do
      let(:mock_server) do
        arr_dep = instance_double(ArrivalDeparture, seconds_until_departure: 300)
        mock = instance_double(Server, arrival_and_departure: arr_dep)
        mock
      end

      describe "with an alarm ready to be triggered" do
        let(:alarm) do
          region.alarms.create!(message: "message", push_identifier: "pushid_123", stop_id: "stopid_123", trip_id: "tripid_123", 
                                service_date: 1234567890, vehicle_id: "vehicle_123", stop_sequence: 1, seconds_before: 300)
        end
        let(:mock_pusher) do
          mock = instance_double(OneSignal)
          expect(mock).to receive(:send_message).with("pushid_123", alarm)
          mock
        end
        let(:checker) { AlarmChecker.new(id: alarm.id, server: mock_server, pusher: mock_pusher) }

        it "sends a push notification" do
          # This spec will fail if the mock_pusher doesn't receive the method #send_message
          checker.check_alarm
        end

        it "deletes the alarm" do
          checker.check_alarm
          expect(Alarm.count).to eq(0)
        end
      end

      describe "with an alarm not ready to be triggered" do
        let(:alarm) do
          region.alarms.create!(message: "message", push_identifier: "pushid_123", stop_id: "stopid_123", trip_id: "tripid_123", 
                                service_date: 1234567890, vehicle_id: "vehicle_123", stop_sequence: 1, seconds_before: 299)
        end
        let(:mock_pusher) do
          mock = instance_double(OneSignal)
          mock
        end
        let(:checker) { AlarmChecker.new(id: alarm.id, server: mock_server, pusher: mock_pusher) }

        it "does not send a push notification" do
          # This spec will fail if the mock_pusher receives the method #send_message
          checker.check_alarm
        end

        it "does not delete the alarm" do
          checker.check_alarm
          expect(Alarm.count).to eq(1)
        end
      end
    end

    context "with a departure in the past" do
      let(:mock_server) do
        arr_dep = instance_double(ArrivalDeparture, seconds_until_departure: -1)
        mock = instance_double(Server, arrival_and_departure: arr_dep)
        mock
      end

      let(:mock_pusher) { instance_double(OneSignal) }

      describe "with an alarm that is overdue to be triggered" do
        let(:alarm) do
          region.alarms.create!(message: "message", push_identifier: "pushid_123", stop_id: "stopid_123", trip_id: "tripid_123", 
                                service_date: 1234567890, vehicle_id: "vehicle_123", stop_sequence: 1, seconds_before: 299)
        end
        let(:checker) { AlarmChecker.new(id: alarm.id, server: mock_server, pusher: mock_pusher) }

        it "does not send a push notification; deletes the alarm" do
          expect(Alarm.count).to eq(0)
        end
      end
    end
  end
end