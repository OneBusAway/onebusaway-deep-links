require 'rails_helper'

RSpec.describe StudyInvite, type: :model do
  it 'requires a name' do
    study_invite = StudyInvite.new
    study_invite.valid?
    expect(study_invite.errors[:name]).to include("can't be blank")
  end
end