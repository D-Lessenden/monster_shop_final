require 'rails_helper'

RSpec.describe 'New Merchant Discount' do
  describe 'As a Merchant' do
    before :each do
      @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
      @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@m_user)
    end

    it 'I can create a discount for a merchant' do
      visit "/merchant/#{@merchant_1.id}/discounts"
      fill_in 'Discount name', with: "FIRE sell. OMG A FIRE sell"
      fill_in 'Percentage off', with: 10
      fill_in 'Minimum amount of items', with: 15
      click_button 'Create Discount'

      expect(current_path).to eq("/merchant/discounts")
      expect(page).to have_link(@merchant_1.discounts.first.name)
      expect(page).to have_content("Percent: #{@merchant_1.discounts.first.percent}")
      expect(page).to have_content("Minimum amount of items: #{@merchant_1.discounts.first.num_of_items}")


    end

  end
end
