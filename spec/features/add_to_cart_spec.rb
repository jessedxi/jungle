require 'rails_helper'

RSpec.feature "Visitor navigates to home page, can click add to cart and cart count increases by one", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario "They can add an item to cart" do
    # ACT
    visit root_path

    click_button('Add', match: :first)


    # VERIFY
    expect(page).to have_css '#navbar', text: 'My Cart (1)'
     
    # DEBUG
     save_screenshot '3_add_cart.png'
  end
end