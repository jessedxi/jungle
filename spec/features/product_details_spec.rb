require 'rails_helper'

RSpec.feature "Visitor navigates to home page, then is brought to a product page when they click on a product", type: :feature, js: true do

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

  scenario "They see the product details page" do
    # ACT
    visit root_path

    first('a.btn-default').click

    # DEBUG
    save_screenshot '2_product_page.png'

    # VERIFY
    expect(page).to have_css 'section.products-show', count: 1
    save_and_open_screenshot '3_product_page.png'
  end
end