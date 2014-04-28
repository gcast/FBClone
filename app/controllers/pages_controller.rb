class PagesController < ApplicationController

	def search
		@results = PgSearch.multisearch(params[:query])
		render :results
	end

end
