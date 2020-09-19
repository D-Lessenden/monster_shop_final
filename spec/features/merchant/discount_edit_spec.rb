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
    expect(page).to have_content("Update Your Discount")
    expect(page).to have_content("Change name")
    expect(page).to have_content("Change amount of items")
    expect(page).to have_content("Change percentage off")
    expect(page).to have_button("Update Discount")
  end

  it "is able to update the info" do
    visit "/merchant/#{@merchant_1.id}/discounts"
    fill_in :name, with: "FIRE sell. OMG A FIRE sell"
    fill_in :percent, with: 10
    fill_in :num_of_items, with: 15
    click_button 'Create Discount'

    visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/edit"

    fill_in :name, with: "qwerty"
    fill_in :percent, with: 9
    fill_in :num_of_items, with: 17
    click_button 'Update Discount'
    expect(current_path).to eq("/merchant/discounts")

    visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/show"
    expect(page).to have_content("Discount name: qwerty")
    expect(page).to have_content("Percentage off: 9")
    expect(page).to have_content("Number of items needed: 17")
  end

  it "if fields are left blank there is an error" do
    visit "/merchant/#{@merchant_1.id}/discounts"
    fill_in :name, with: "FIRE sell. OMG A FIRE sell"
    fill_in :percent, with: 10
    fill_in :num_of_items, with: 15
    click_button 'Create Discount'

    visit "/merchant/discounts/#{@merchant_1.discounts.first.id}/edit"

    fill_in :name, with: "qwerty"
    fill_in :percent, with: 9
    click_button 'Update Discount'
    expect(current_path).to eq("/merchant/discounts/#{@merchant_1.discounts.first.id}/edit")
    expect(page).to have_content("Num of items can't be blank")
  end

end
