require 'rails_helper'

RSpec.feature "User can log in and is brought to home page", type: :feature, js: true do

    # SETUP
    before :each do
      User.create!(
        first_name: 'Matt',
        last_name: 'Damon',
        email: 'goodwill@hunting.com',
        password: 'robin',
        password_confirmation: 'robin'
      )
    end

  scenario "They can log in with a correct username and password, they are then brought to home page" do
    # ACT
    visit login_path

    # VERIFY
    fill_in'email', with:'goodwill@hunting.com'
    fill_in'password', with:'robin'

    click_button('Submit')

    expect(page).to have_content('Signed in as Matt')

    # DEBUG
    save_screenshot '4_logged_in.jpg'

  end
end