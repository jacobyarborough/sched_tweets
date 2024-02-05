require 'rails_helper'

RSpec.describe 'New Regestration Page' do
  context 'when the form inputs are valid' do
    describe 'new user registration' do
      it 'allows users to fill in a form and sign up' do
        visit new_registrations_path
        fill_in("email", with: "new@mail.com")
        fill_in("password", with: "password")
        fill_in("password confirmation", with: "password")
        click_on "Create User"

        expect(page).to have_current_path(root_path)
        expect(page).to have_content("Successfully created account!")
      end
    end
  end 

  context 'when the form inputs are invalid' do
    describe 'new user registration' do
      it 'should re-render the form with an error message' do
        visit new_registrations_path
        fill_in("email", with: "new@mail.com")
        fill_in("password", with: "password")
        click_on "Create User"

      
        expect(page).to have_content("Password confirmation doesn't match Password")
        expect(page).to have_http_status(422)
      end
    end
  end
end