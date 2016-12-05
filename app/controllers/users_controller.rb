class UsersController < ApplicationController

	def state_facebook
		if current_user.state_facebook == true
			current_user.update_attribute(:state_facebook, false)
		else
			current_user.update_attribute(:state_facebook, true)
		end
	end

	def state_twitter
		if current_user.state_twitter == true
			current_user.update_attribute(:state_twitter, false)
		else
			current_user.update_attribute(:state_twitter, true)
		end
	end
end
