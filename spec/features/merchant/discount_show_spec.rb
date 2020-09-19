require 'rails_helper'

RSpec.describe 'As a merchant-employee' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@megan)
    end

    it "has all relevant info on the show page and a link to edit the discount" do
      visit "/merchant/#{@merchant_1.id}/discounts"
      fill_in :name, with: "FIRE sell. OMG A FIRE sell"
      fill_in :percent, with: 10
      fill_in :num_of_items, with: 15
      click_button 'Create Discount'

      visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/show"
      expect(page).to have_content(@merchant_1.discounts.first.percent )
      expect(page).to have_content(@merchant_1.discounts.first.num_of_items)
      expect(page).to have_link("Edit Discount")
      click_on "Edit Discount"
      expect(current_path).to eq("/merchant/discounts/#{@merchant_1.discounts.first.id}/edit")
  end

  it "has a link 'My Discounts'" do
    visit '/merchant'

    expect(page).to have_content("My Discounts")
    click_on("My Discounts")
    expect(current_path).to eq("/merchant/discounts")
  end

  it 'has a link to delete a discount' do
    visit "/merchant/#{@merchant_1.id}/discounts"
    fill_in :name, with: "FIRE sell. OMG A FIRE sell"
    fill_in :percent, with: 10
    fill_in :num_of_items, with: 15
    click_button 'Create Discount'
    visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/show"
    expect(page).to have_content("Delete Discount")
  end
end
