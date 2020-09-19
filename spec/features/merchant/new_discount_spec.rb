require 'rails_helper'

RSpec.describe 'New Merchant Discount' do
  describe 'As a Merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@megan)
    end

    it 'I can create a discount for a merchant' do
      visit "/merchant/#{@merchant_1.id}/discounts"
      fill_in :name, with: "FIRE sell. OMG A FIRE sell"
      fill_in :percent, with: 10
      fill_in :num_of_items, with: 15
      click_button 'Create Discount'
      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_link(@merchant_1.discounts.first.name)

      visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/show"

      expect(page).to have_content(@merchant_1.discounts.first.name)
      expect(page).to have_content(@merchant_1.discounts.first.percent)
      expect(page).to have_content(@merchant_1.discounts.first.num_of_items)
    end

    it "doesn't create with blank fields" do
      visit "/merchant/#{@merchant_1.id}/discounts"
      fill_in :name, with: "FIRE sell. OMG A FIRE sell"
      fill_in :percent, with: 10
      click_button 'Create Discount'
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/discounts")
      expect(page).to have_content("Num of items can't be blank")
    end

  end
end
