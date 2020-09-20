require 'rails_helper'

RSpec.describe 'As a merchant-employee' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@megan)
    end

    it 'has a link from the index page to show pages' do
      visit "/login"
      fill_in :email, with: 'megan@example.com'
      fill_in :password, with: @megan.password
      click_button "Log In"

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
      visit "/login"
      fill_in :email, with: 'megan@example.com'
      fill_in :password, with: @megan.password
      click_button "Log In"

      visit "/merchant/discounts"
      expect(page).to have_content("Create Discount")
      click_on "Create Discount"
      expect(current_path).to eq("/merchant/#{@merchant_1.id}/discounts")
    end

    it 'has a link to delete a discount' do
      visit "/login"
      fill_in :email, with: 'megan@example.com'
      fill_in :password, with: @megan.password
      click_button "Log In"

      discount1 = Discount.create(name: "FIRE sell. OMG A FIRE sell", percent: 10, num_of_items: 15, merchant_id: @merchant_1.id)
      visit "/merchant/discounts"
      expect(page).to have_content("Delete Discount")
      click_link "Delete Discount"

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to_not have_content(discount1.name)
    end

    it 'can have more than one discount' do
      visit "/login"
      fill_in :email, with: 'megan@example.com'
      fill_in :password, with: @megan.password
      click_button "Log In"

      discount1 = Discount.create(name: "FIRE sell. OMG A FIRE sell", percent: 10, num_of_items: 15, merchant_id: @merchant_1.id)
      discount2 = Discount.create(name: "DISCOUNT2", percent: 10, num_of_items: 15, merchant_id: @merchant_1.id)

      visit "/merchant/discounts"
      expect(page).to have_content(discount1.name)
      expect(page).to have_content(discount2.name)
    end 
end
