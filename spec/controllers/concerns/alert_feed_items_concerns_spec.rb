require 'rails_helper'

RSpec.describe AlertFeedItemsConcerns, type: :controller do
  before :all do
    class FakeController < ApplicationController
      include AlertFeedItemsConcerns
    end
  end

  describe '.condition_filters' do
    it 'should not filter by starts_at when a `since` parameter is not provided' do
      controller = FakeController.new
      conditions = controller.condition_filters()
      expect(conditions).to eql({})
    end

    it 'should provide a starts_at Datetime range when a `since` parameter is provided' do
      controller = FakeController.new
      conditions = controller.condition_filters(since: 5.days.ago.utc.to_i)
      expect(conditions.key?(:starts_at)).to be true
      expect(conditions[:starts_at].to_s).to eql((5.days.ago.utc..Time.now.utc).to_s)
    end
  end
end
