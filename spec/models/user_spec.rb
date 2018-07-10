require 'rails_helper'

RSpec.describe User, type: :model do

	context 'Associations' do
	    it 'has_many councils' do
	      association = described_class.reflect_on_association(:councils).macro
	      expect(association).to eq :has_many
	    end
    
	    it 'has_many memberships' do
	      association = described_class.reflect_on_association(:memberships)
	      expect(association.macro).to eq :has_many
		  expect(association.options[:dependent]).to eq :destroy
	    end
    end

end