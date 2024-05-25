require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "password_reset" do
    let(:region) { create_puget_sound_region! }
    let(:admin) { Admin.create_admin!("Admin Name", "admin@example.com", region.id) }
    let(:mail) { UserMailer.password_reset(admin) }

    it "renders the headers" do
      expect(mail.subject).to eq("Password reset")
      expect(mail.to).to eq(["admin@example.com"])
      expect(mail.from).to eq(["aaron@onebusaway.org"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end
end
