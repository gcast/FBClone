class NotificationsController < ApplicationController

	before_action :ensure_current_user!

	def index
		@notifications = current_user.notifications
	end

	def show
		notification = Notification.find(params[:id])
		notification.update({ is_read?: true })
		redirect_to notification.get_url
	end

end
