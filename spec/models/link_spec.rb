require 'rails_helper'

RSpec.describe Link, type: :model do
  it "always has an orginal URL and a short code" do
		link = Link.new(
				original_url: "https://www.favoritewebsite.com/articles/how-to-cook",
				lookup_code: "1234567"
			)
		expect(link.valid?).to be(true)
	end

	it "is invalid if does not have a lookup code" do
		link = Link.new(
				original_url: "https://www.favoritewebsite.com/articles/how-to-cook"
			)
		expect(link.valid?).to be(false)
	end

	it "is invalid if does not have an original url" do
		link = Link.new(
				lookup_code: "1234567"
			)
		expect(link.valid?).to be(false)
	end

	it "is invalid if the lookup code already exists" do
		link = Link.new(
				original_url: "https://www.favoritewebsite.com/articles/how-to-cook",
				lookup_code: "1234567"
			)
		link.save

		link2 = Link.new(
				original_url: "https://www.favoritewebsite.com/articles/how-to-bake",
				lookup_code: "1234567"
			)
		expect(link2.valid?).to be(false) 
	end
end
