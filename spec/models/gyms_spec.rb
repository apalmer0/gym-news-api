require 'rails_helper'

RSpec.describe Gym do
  describe 'associations' do
    def association
      described_class.reflect_on_association(:climbs)
      # stands for the class you're working with in this block, specifically 'Gym'
    end

    it 'has many climbs' do
      expect(association).not_to be_nil
      expect(association.options[:inverse_of]).not_to be_nil
    end

    it 'deletes associated climbs when destroy' do
      expect(association.options[:dependent]).to eq(:destroy)
    end

  end
end
