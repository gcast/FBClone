class VisitsController < ApplicationController

	def create
		@visit = Visit.new(:ip_address => params[:ip_address])
		@visit.save

		if request.xhr?
			render json: @visit
		else
			render nothing: true
		end	
	end




end
