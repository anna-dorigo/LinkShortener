class LinksController < ApplicationController

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

end