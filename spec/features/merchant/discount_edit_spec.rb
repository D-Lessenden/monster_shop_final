require 'rails_helper'

RSpec.describe 'As a merchant-employee' do
  before :each do
    @merchant_1 = Merchant.create!(name: 'Megans Marmalades', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218)
    @megan = @merchant_1.users.create(name: 'Megan', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, email: 'megan@example.com', password: 'securepassword')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@megan)
  end

  it "has all of the appropiate fields" do
    visit "/merchant/#{@merchant_1.id}/discounts"
    fill_in :name, with: "FIRE sell. OMG A FIRE sell"
    fill_in :percent, with: 10
    fill_in :num_of_items, with: 15
    click_button 'Create Discount'


    visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/edit"
    expect(page).to have_content("Edit Discount")
    expect(page).to have_content("Change name")
    expect(page).to have_content("Change amount of items")
    expect(page).to have_content("Change percentage off")
    expect(page).to have_button("Update Discount")
  end
end
