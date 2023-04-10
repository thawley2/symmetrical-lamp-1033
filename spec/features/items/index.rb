require 'rails_helper'

RSpec.describe '/items', type: :feature do
  let!(:walmart) { Supermarket.create!(name: 'Walmart', location: 'East') }
  let!(:kroger) { Supermarket.create!(name: 'Kroger', location: 'West') }
  let!(:sams) { Supermarket.create!(name: 'Sams', location: 'West') }

  let!(:eggs) { walmart.items.create!(name: 'Eggs', price: 15) }
  let!(:bacon) { kroger.items.create!(name: 'Bacon', price: 5) }
  let!(:potatoes) { walmart.items.create!(name: 'Potatoes', price: 2) }
  let!(:coffee) { walmart.items.create!(name: 'Coffee', price: 3) }
  let!(:steak) { sams.items.create!(name: 'Steak', price: 14) }
  let!(:beer) { sams.items.create!(name: 'Beer', price: 1) }

  let!(:thomas) { Customer.create!(name: 'Thomas')}
  let!(:jeff) { Customer.create!(name: 'Jeff')}
  let!(:steve) { Customer.create!(name: 'Steve')}

  let!(:supit1) {CustomerItem.create!(customer: thomas, item: eggs)}
  let!(:supit2) {CustomerItem.create!(customer: thomas, item: bacon)}
  let!(:supit3) {CustomerItem.create!(customer: thomas, item: coffee)}
  let!(:supit4) {CustomerItem.create!(customer: jeff, item: eggs)}
  let!(:supit5) {CustomerItem.create!(customer: jeff, item: steak)}
  let!(:supit6) {CustomerItem.create!(customer: jeff, item: potatoes)}
  let!(:supit7) {CustomerItem.create!(customer: steve, item: potatoes)}
  let!(:supit8) {CustomerItem.create!(customer: steve, item: eggs)}

  describe 'When I visit the items index page' do
    it 'I see a list of all items names' do
      visit '/items'

      expect(page).to have_content('Eggs')
      expect(page).to have_content('Bacon')
      expect(page).to have_content('Potatoes')
      expect(page).to have_content('Coffee')
      expect(page).to have_content('Steak')
    end

    it 'I also see the price and name of the supermarket and purchase count with each item' do
      visit '/items'
# save_and_open_page
      within "#item_#{eggs.id}" do
        expect(page).to have_content('Price: 15')
        expect(page).to have_content('Supermarket: Walmart')
        expect(page).to have_content('Purchase Count: 3')
      end
      within "#item_#{bacon.id}" do
        expect(page).to have_content('Price: 5')
        expect(page).to have_content('Supermarket: Kroger')
        expect(page).to have_content('Purchase Count: 1')
      end
      within "#item_#{coffee.id}" do
        expect(page).to have_content('Price: 3')
        expect(page).to have_content('Supermarket: Walmart')
        expect(page).to have_content('Purchase Count: 1')
      end
      within "#item_#{potatoes.id}" do
        expect(page).to have_content('Price: 2')
        expect(page).to have_content('Supermarket: Walmart')
        expect(page).to have_content('Purchase Count: 2')
      end
      within "#item_#{steak.id}" do
        expect(page).to have_content('Price: 14')
        expect(page).to have_content('Supermarket: Sams')
        expect(page).to have_content('Purchase Count: 1')
      end
      within "#item_#{beer.id}" do
        expect(page).to have_content('Price: 1')
        expect(page).to have_content('Supermarket: Sams')
        expect(page).to have_content('Purchase Count: 0')
      end
    end
  end
end