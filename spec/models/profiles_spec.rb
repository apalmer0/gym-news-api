require 'rails_helper'

RSpec.describe Profile do
  describe 'associations' do
    def association
      described_class.reflect_on_association(:user)
      # described_class.reflect_on_association(:user)
    end

    it 'belongs to a user' do
      expect(association).to_not be_nil
      expect(association.options[:inverse_of]).to_not be_nil
    end
  end
end
