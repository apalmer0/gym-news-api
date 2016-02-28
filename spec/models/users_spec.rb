require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    def association
      described_class.reflect_on_association(:profile)
      # stands for the class you're working with in this block, specifically 'Article'
    end

    it 'has one profile' do
      expect(association).not_to be_nil
      expect(association.options[:inverse_of]).not_to be_nil
    end

    it 'deletes associated profile when destroyed' do
      expect(association.options[:dependent]).to eq(:destroy)
    end

  end
end
