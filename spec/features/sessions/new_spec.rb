require 'rails_helper'

RSpec.describe "New Session Page" do
  let!(:user) { User.create(email: "example@mail.com", password: "password", password_confirmation: "password") }
  
  context 'when the credentials are valid' do
    it 'should allow a user to sign in' do
      visit new_sessions_path

      fill_in("email", with: "example@mail.com")
      fill_in("password", with: "password")
      within("div.container") do
        click_on("Sign In")
      end

      expect(page).to have_current_path(root_path)
      expect(page).to have_content("Successfully signed in")
    end
  end

  context 'when the credentials are invalid' do
    it 're-renders the sign-in page and displays an error' do
      visit new_sessions_path
      
      fill_in("email", with: "blah@mail.com")
      fill_in("password", with: "password")
      within("div.container") do
        click_on("Sign In")
      end

      expect(page).to have_http_status(422)
      expect(page).to have_content("Incorrect email/password")
      # expect(page).to have_current_path(new_sessions_path)
    end
  end
end