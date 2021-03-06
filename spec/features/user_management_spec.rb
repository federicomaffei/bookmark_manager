require 'spec_helper'

feature "User signs in" do
  before(:each) do
    User.create(:email => "test@test.com", 
      :password => 'test', 
      :password_confirmation => 'test', 
      :password_token => '', 
      :password_token_time => '')
  end

  scenario "with correct credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'test')
    expect(page).to have_content("Welcome, test@test.com")
  end

  scenario "with incorrect credentials" do
    visit '/'
    expect(page).not_to have_content("Welcome, test@test.com")
    sign_in('test@test.com', 'wrong')
    expect(page).not_to have_content("Welcome, test@test.com")
  end
end

feature "User signs out" do
  before(:each) do
    User.create(:email => "test@test.com", 
      :password => 'test', 
      :password_confirmation => 'test', 
      :password_token => '', 
      :password_token_time => '')
  end

  scenario 'while being signed in' do
    sign_in('test@test.com', 'test')
    click_button 'sign out'
    expect(page).to have_content("Good bye!") # where does this message go?
    expect(page).not_to have_content("Welcome, test@test.com")
  end
end



feature "User signs up" do
  scenario "when being logged out" do    
    expect(lambda { sign_up }).to change(User, :count).by(1)    
    expect(page).to have_content("Welcome, alice@example.com")
    expect(User.first.email).to eq("alice@example.com")        
  end
  
  scenario "with a password that doesn't match" do
    expect(lambda { sign_up('a@a.com', 'pass', 'wrong') }).to change(User, :count).by(0)
    expect(current_path).to eq('/users')   
    expect(page).to have_content("Sorry, your passwords don't match")
  end

  scenario "with an email that is already registered" do    
    expect(lambda { sign_up }).to change(User, :count).by(1)
    expect(lambda { sign_up }).to change(User, :count).by(0)
    expect(page).to have_content("This email is already taken")
  end
end


feature "User forgets the password" do
  scenario 'and visits a page that allows the recovery' do
    visit('/users/reset_password')
    expect(page).to have_content('please enter your email to recover the password.')
  end
end