require 'rails_helper'

RSpec.feature "Visitors can add a product to the cart from the home page", type: :feature, js: true do

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
  
  scenario "The text rendered in the cart changes from 'My Cart (0)'' to 'My Cart (1)'" do
    # ACT
    visit root_path
    # find("a.btn.btn-default.pull-right", match: :first).click
    first('article.product').find('button.btn.btn-primary').click
    
    # VERIFY & DEBUG
    expect(page).to have_text 'My Cart (1)'
    save_screenshot ("add_to_cart.png")
  end

end