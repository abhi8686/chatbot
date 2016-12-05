class NotificationsController < ApplicationController
	def index
		if user_signed_in?
			@statuses = current_user.statuses.all
		end
	end
end
