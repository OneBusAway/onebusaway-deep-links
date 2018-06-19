require 'rails_helper'

RSpec.describe Region, type: :model do
  let(:region) { create_puget_sound_region! }
    
  describe '.bounding_rect' do
    it 'calculates the bounding rect for the region' do
      expect(region.bounding_rect.x).to equal(46.933117)
      expect(region.bounding_rect.y).to equal(-123.3964)
      expect(region.bounding_rect.width).to equal(1.7098829999999978)
      expect(region.bounding_rect.height).to equal(1.7954318940305)
    end
  end
  
  describe '.region_center' do
    it 'calculates the center point of the region' do
      expect(region.region_center.lat).to equal(47.788058500000005)
    expect(region.region_center.lon).to equal(-122.49868405298474)
    end
  end
end