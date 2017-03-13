require 'rails_helper'

RSpec.describe AlertFeedItemsConcerns, type: :controller do
  before :all do
    class FakeController < ApplicationController
      include AlertFeedItemsConcerns
    end
  end

  describe '.condition_filters' do
    it 'should not filter by published_at when a `since` parameter is not provided' do
      controller = FakeController.new
      conditions = controller.condition_filters()
      expect(conditions).to eql({})
    end

    it 'should provide a published_at Datetime range when a `since` parameter is provided' do
      controller = FakeController.new
      conditions = controller.condition_filters(since: 5.days.ago.utc.to_i)
      expect(conditions.key?(:published_at)).to be true
      expect(conditions[:published_at].to_s).to eql((5.days.ago.utc..Time.now.utc).to_s)
    end
  end
end
