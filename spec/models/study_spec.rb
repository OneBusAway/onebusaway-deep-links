require 'rails_helper'

RSpec.describe Study, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      study = Study.new(name: 'Test Study', description: 'Test Description', region: Region.new)
      expect(study).to be_valid
    end

    it 'is not valid without a name' do
      study = Study.new(name: nil)
      expect(study).not_to be_valid
    end

    it 'is not valid without a description' do
      study = Study.new(description: nil)
      expect(study).not_to be_valid
    end

    it 'is not valid without a region' do
      study = Study.new(region: nil)
      expect(study).not_to be_valid
    end
  end

  describe 'normalization' do
    it 'removes leading and trailing whitespace from name' do
      study = Study.new(name: ' Test Study ')
      expect(study.name).to eq('Test Study')
    end

    it 'removes leading and trailing whitespace from description' do
      study = Study.new(description: ' Test Description ')
      expect(study.description).to eq('Test Description')
    end
  end

  describe 'study invites' do
    it 'creates a study invite on creation' do
      study = Study.create(name: 'Test Study', description: 'Test Description', region: create(:region))
      expect(study.study_invites.count).to eq(1)
    end
  end
end