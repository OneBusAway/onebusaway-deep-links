require 'rails_helper'

RSpec.describe Survey, type: :model do
  it 'requires a name' do
    survey = Survey.new
    survey.valid?
    expect(survey.errors[:name]).to include("can't be blank")
  end
end