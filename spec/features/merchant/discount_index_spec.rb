require 'rails_helper'

RSpec.describe 'As a merchant-employee' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@megan)
    end

    it 'has a link from the index page to show pages' do
      visit "/merchant/#{@merchant_1.id}/discounts"
      fill_in :name, with: "FIRE sell. OMG A FIRE sell"
      fill_in :percent, with: 10
      fill_in :num_of_items, with: 15
      click_button 'Create Discount'

      expect(current_path).to eq('/merchant/discounts')
      expect(page).to have_content(@merchant_1.discounts.first.name)
      click_on "#{@merchant_1.discounts.first.name}"
      expect(current_path).to eq("/merchant/discounts/#{@merchant_1.discounts.first.id}/show")
    end

    it 'has a link to create a discount' do
      visit "/merchant/discounts"
      expect(page).to have_content("Create Discount")
      click_on "Create Discount"
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/discounts")

    end

end
