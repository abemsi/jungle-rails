require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail page", type: :feature, js: true do

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
  
  scenario "They see the details of a specific product" do
    # ACT
    visit root_path
    find("a.btn.btn-default.pull-right", match: :first).click
    # first('article.product').find('a.btn.btn-default.pull-right').click
    
    # VERIFY & DEBUG
    expect(page).to have_css 'article.product-detail', count: 1
    save_screenshot ("product_detail.png")
  end

end

