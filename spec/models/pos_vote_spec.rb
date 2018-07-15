require 'rails_helper'

RSpec.describe PosVote, type: :model do
	it 'belongs_to user' do
	      association = described_class.reflect_on_association(:user).macro
	      expect(association).to eq :belongs_to
	end
	
	it 'belongs_to council' do
	    association = described_class.reflect_on_association(:council).macro
	    expect(association).to eq :belongs_to
	end

	it 'belongs_to council' do
	    association = described_class.reflect_on_association(:council).macro
	    expect(association).to eq :belongs_to
	end

	it 'belongs_to vote_id' do
	    association = described_class.reflect_on_association(:vote_id).macro
	    expect(association).to eq :belongs_to
	end
end
