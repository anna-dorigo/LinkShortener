class LinksController < ApplicationController

	def redirect
		url_string = params[:lookup_code]
		if url_string.chr == "_"
			link = Link.find_by(lookup_code: url_string)
		else
			link = Link.find_by(slug: url_string)
		end

		if link.state
			redirect_to link.original_url
		else
			render "page_inactive"
		end
	end

	def create
		original_url = params[:link][:original_url]
		slug = params[:link][:slug]
		lookup_code_string = lookup_code()
		if slug == ""
			@link = Link.create(original_url: original_url, lookup_code: lookup_code_string)
		else
			@link = Link.create(original_url: original_url, lookup_code: lookup_code_string, slug: slug)
		end 

		if @link.persisted?
			respond_to :js
		else
			render 'error.js.erb'
		end
	end

	def display
		
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

	def lookup_code
		loop do
			code = get_fresh_code()
			break code unless Link.exists?(lookup_code: code)
		end	
	end

	private

	def get_fresh_code()
		"_"+SecureRandom.uuid[0..5]
	end

end