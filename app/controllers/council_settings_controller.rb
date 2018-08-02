class CouncilSettingsController < ApplicationController

	def edit
		@old_settings = CouncilSetting.find(params[:id])

	end

	def update
		@old_settings = CouncilSetting.find(params[:id])

		@settings = CouncilSetting.new(settings_params)
		@settings.user_id = current_user.id
		@settings.council_id = @old_settings.council.id
		@diff = false
		if @settings.memb_vote_threshold != @old_settings.memb_vote_threshold
			@diff = true
		end
		if @settings.min_mot_vote != @old_settings.min_mot_vote
			@diff = true
		end
		if @settings.campaign_length != @old_settings.campaign_length
			@diff = true
		end
		if @settings.enactment_delay != @old_settings.enactment_delay
			@diff = true
		end
		if @settings.membership_area != @old_settings.membership_area
			@diff = true
		end
		if @settings.membership_area == 'Distance'
			if @settings.membership_distance != @old_settings.membership_distance
				@diff = true
			end
		end

		redirect_to edit_council_council_setting_path(@settings.council, @old_settings, user: @settings.membership_distance, diff: @diff)
		
	end

	private

	def settings_params
	  params.require(:council_setting).permit(:memb_vote_threshold, :min_mot_vote, :campaign_length, :enactment_delay, :membership_area, :membership_distance)
	end
end
