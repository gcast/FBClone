class PagesController < ApplicationController

	before_action :ensure_current_user!

	def search
		@results = PgSearch.multisearch(params[:query])
		render :results
	end

end
