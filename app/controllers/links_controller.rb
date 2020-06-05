class LinksController < ApplicationController

	def redirect
		link = Link.find_by(lookup_code: params[:lookup_code])
		redirect_to link.original_url
	end

	def create
		original_url = params[:link][:original_url]
		shortener = Shortener.new(original_url)
		@link = shortener.generate_short_link

		if @link.persisted?
			respond_to :js
		else
			render 'error.js.erb'
		end
	end

	def display
		puts "----------display!!!!! -------"
	end

	def destroy
		@link = Link.find(params[:id])
		@link.destroy
		@id = params[:id]
    	if !Link.exists?(params[:id])
    		respond_to :js
    	end
	end

	def change_state
		@link = Link.find(params[:id])
		if @link.state
			@link.update_attribute(:state, false)
		else
			@link.update_attribute(:state, true)
		end
		respond_to :js

	end

end