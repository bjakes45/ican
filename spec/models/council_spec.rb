require 'rails_helper'

RSpec.describe Council, type: :model do

	context 'Associations' do
	    it 'belongs_to user' do
	      association = described_class.reflect_on_association(:user).macro
	      expect(association).to eq :belongs_to
	    end
    
	    it 'has_many memberships' do
	      association = described_class.reflect_on_association(:memberships).macro
	      expect(association).to eq :has_many
	    end
    end

end
