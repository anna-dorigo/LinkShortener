require "rails_helper"

RSpec.describe Shortener do 

	it "shortenes a given URL to a 7 character lookup code" do 
		url = "https://www.favoritewebsite.com/articles/how-to-cook"
		shortener = Shortener.new(url)
		expect(shortener.lookup_code.length).to eq(7)
	end

	it "gives each URL its own lookup code" do 
		url = "https://www.favoritewebsite.com/articles/how-to-cook"
		shortener = Shortener.new(url)
		code_1 = shortener.lookup_code

		url = "https://www.favoritewebsite.com/articles/how-to-bake"
		shortener = Shortener.new(url)
		code_2 = shortener.lookup_code

		expect(code_2).not_to eq(code_1)
	end

	it "always gives the same URL the same lookup code" do
		url = "https://www.favoritewebsite.com/articles/how-to-cook"
		shortener_1 = Shortener.new(url)
		code_1 = shortener_1.lookup_code

		shortener_2 = Shortener.new(url)
		code_2 = shortener_2.lookup_code

		expect(code_2).to eq(code_2)
	end

	it "generates a link record with a unique lookup code" do
		url = "https://www.favoritewebsite.com/articles/how-to-cook"
		shortener = Shortener.new(url)
		link = shortener.generate_short_link
		expect(link.valid?).to be(true)

		link2 = shortener.generate_short_link
		expect(link2.valid?).to be(true)
	end

end