require 'spec_helper'

feature "User adds a new link" do
	before(:each) do
		User.create(:email => "test@test.com", 
			:password => 'test', 
			:password_confirmation => 'test', 
			:password_token => '', 
			:password_token_time => '')
	end

	scenario "when browsing the homepage" do
		expect(Link.count).to eq(0)
		visit '/links/new'
		add_link("www.makersacademy.com/", "Makers Academy")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.url).to eq "www.makersacademy.com/"
		expect(link.title).to eq "Makers Academy"
		expect(link.created_by).to eq "unsigned user"
	end

	scenario "as a signed user, email is saved" do
		sign_in("test@test.com", 'test')
		expect(Link.count).to eq(0)
		visit '/links/new'
		add_link("www.makersacademy.com/", "Makers Academy")
		expect(Link.count).to eq(1)
		link = Link.first
		expect(link.created_by).to eq "test@test.com"
	end


	def add_link(url, title)
		within('#new-link') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			click_button 'Add link'
		end      
	end

	scenario "with a few tags" do
		visit "/links/new"
		add_link("http://www.makersacademy.com/", 
			"Makers Academy", 
			['education', 'ruby'], "A highly selective 12 week coding course in London.")    
		link = Link.first
		expect(link.tags.map(&:text)).to include("education")
		expect(link.tags.map(&:text)).to include("ruby")
	end

	scenario "with a description" do
		visit "/links/new"
		add_link("http://www.makersacademy.com/", 
			"Makers Academy", 
			['education', 'ruby'], "A highly selective 12 week coding course in London.")    
		link = Link.first
		expect(link.description).to eq "A highly selective 12 week coding course in London."
	end



	def add_link(url, title, tags = [], description = "")
		within('#new-link') do
			fill_in 'url', :with => url
			fill_in 'title', :with => title
			# our tags will be space separated
			fill_in 'tags', :with => tags.join(' ')
			fill_in 'description', :with => description
			click_button 'Add link'
		end      
	end
end