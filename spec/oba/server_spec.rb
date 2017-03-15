require 'rails_helper'
require_dependency 'oba/server'

RSpec.describe Server do
  context "with Tampa's API server" do
    let(:server) { Server.new("http://api.tampa.onebusaway.org/api/") }
    describe "creating arrival and departure URLs" do
      context "given proper parameters" do
        let(:params) { {
          "region_id": "0",
          "seconds_before": "600",
          "service_date": "1489464000000",
          "stop_id": "Hillsborough Area Regional Transit_7690",
          "stop_sequence": "6",
          "trip_id": "Hillsborough Area Regional Transit_234900",
          "user_push_id": "fb7971e9-d49b-45bb-8581-7089a1a6bc04",
          "vehicle_id": "Hillsborough Area Regional Transit_1029"
        } }

        it "creates a correct request URL with params" do
          url = server.build_arrival_and_departure_url(params)
          expect(url).to eq("http://api.tampa.onebusaway.org/api/api/where/arrival-and-departure-for-stop/Hillsborough%20Area%20Regional%20Transit_7690.json?app_uid=C071187D-67E0-458C-A1DA-CADE062AE667&app_ver=20170105.12&key=org.onebusaway.iphone&serviceDate=1489464000000&stopSequence=6&tripId=Hillsborough+Area+Regional+Transit_234900&vehicleId=Hillsborough+Area+Regional+Transit_1029&version=2")
        end
      end
    end # describe
  end
end
