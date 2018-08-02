class CouncilSetting < ActiveRecord::Base
	belongs_to :user
	belongs_to :council

end
