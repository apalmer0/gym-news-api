require 'rails_helper'

RSpec.describe Climb do
  describe 'associations' do
    def gym_association
      described_class.reflect_on_association(:gym)
      # described_class.reflect_on_association(:user)
    end

    it 'belongs to a gym' do
      expect(gym_association).to_not be_nil
      expect(gym_association.options[:inverse_of]).to_not be_nil
    end
  end
end
