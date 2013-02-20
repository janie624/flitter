class FlitsController < ApplicationController

	def create
		flit = current_user.flits.build(:message => params[:flit][:message][0..139])
		flit.save!
		redirect_to root_path
	end

	def destroy
	end
end
