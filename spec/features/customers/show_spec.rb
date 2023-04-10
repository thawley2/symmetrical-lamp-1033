require 'rails_helper'

RSpec.describe '/customer/:id', type: :feature do
  let!(:walmart) { Supermarket.create!(name: 'Walmart', location: 'East') }
  let!(:kroger) { Supermarket.create!(name: 'Kroger', location: 'West') }

  let!(:eggs) { walmart.items.create!(name: 'Eggs', price: 15) }
  let!(:bacon) { kroger.items.create!(name: 'Bacon', price: 5) }
  let!(:potatoes) { walmart.items.create!(name: 'Potatoes', price: 2) }
  let!(:coffee) { walmart.items.create!(name: 'Coffee', price: 3) }
  let!(:steak) { walmart.items.create!(name: 'Steak', price: 14) }

  let!(:thomas) { Customer.create!(name: 'Thomas')}
  let!(:jeff) { Customer.create!(name: 'Jeff')}
  let!(:steve) { Customer.create!(name: 'Steve')}

  let!(:supit1) {CustomerItem.create!(customer: thomas, item: eggs)}
  let!(:supit2) {CustomerItem.create!(customer: thomas, item: bacon)}
  let!(:supit3) {CustomerItem.create!(customer: thomas, item: coffee)}
  let!(:supit4) {CustomerItem.create!(customer: jeff, item: eggs)}
  let!(:supit5) {CustomerItem.create!(customer: jeff, item: steak)}
  let!(:supit6) {CustomerItem.create!(customer: steve, item: potatoes)}

  describe 'When I visit a customer show page' do
    it 'I see a customers name and a list of all items' do
      visit "/customers/#{thomas.id}"
# save_and_open_page
      expect(page).to have_content('Customer Name: Thomas')
      expect(page).to have_content('Eggs')
      expect(page).to have_content('Bacon')
      expect(page).to have_content('Coffee')

    end

    it 'I also see the price and the name of the supermarket that the item belongs to' do
      visit "/customers/#{thomas.id}"

      within "#item_#{eggs.id}" do
        expect(page).to have_content('Price: 15')
        expect(page).to have_content('Supermarket: Walmart')
      end
      within "#item_#{bacon.id}" do
        expect(page).to have_content('Price: 5')
        expect(page).to have_content('Supermarket: Kroger')
      end
      within "#item_#{coffee.id}" do
        expect(page).to have_content('Price: 3')
        expect(page).to have_content('Supermarket: Walmart')
      end
    end
  end
end