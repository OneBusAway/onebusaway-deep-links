require 'rails_helper'

RSpec.describe Server do
  context "with Tampa's API server" do
    let(:server) { Server.new("http://api.tampa.onebusaway.org/api/") }
    describe "creating arrival and departure URLs" do
      context "given proper parameters" do
        let(:stop_id) { "Hillsborough Area Regional Transit_7690" }
        let(:stop_sequence) { "6" }
        let(:service_date) { "1489464000000" }
        let(:trip_id) { "Hillsborough Area Regional Transit_234900" }
        let(:vehicle_id) { "Hillsborough Area Regional Transit_1029" }

        it "creates a correct request URL with params" do
          url = server.build_arrival_and_departure_url(stop_id: stop_id, stop_sequence: stop_sequence, 
                                                       service_date: service_date, trip_id: trip_id, vehicle_id: vehicle_id)
          expect(url).to eq("http://api.tampa.onebusaway.org/api/api/where/arrival-and-departure-for-stop/Hillsborough%20Area%20Regional%20Transit_7690.json?app_uid=C071187D-67E0-458C-A1DA-CADE062AE667&app_ver=20170105.12&key=org.onebusaway.iphone&serviceDate=1489464000000&stopSequence=6&tripId=Hillsborough+Area+Regional+Transit_234900&vehicleId=Hillsborough+Area+Regional+Transit_1029&version=2")
        end
      end
    end # describe
  end
end
