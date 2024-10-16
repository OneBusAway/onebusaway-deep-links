RSpec.describe Survey, type: :model do
  it 'requires a name' do
    survey = Survey.new
    expect(survey).to_not be_valid
    expect(survey.errors[:name]).to include("can't be blank")
  end

  it 'requires a start_date if end_date is provided' do
    survey = Survey.new(end_date: Time.current + 1.day)
    expect(survey).to_not be_valid
    expect(survey.errors[:start_date]).to include("must be present if end_date is provided")
  end

  it 'requires an end_date if start_date is provided' do
    survey = Survey.new(start_date: Time.current)
    expect(survey).to_not be_valid
    expect(survey.errors[:end_date]).to include("must be present if start_date is provided")
  end

  it 'validates that end_date must be after start_date' do
    survey = Survey.new(start_date: Time.current, end_date: Time.current - 1.day)
    expect(survey).to_not be_valid
    expect(survey.errors[:end_date]).to include("must be after the start date")
  end
end
