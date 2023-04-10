require 'rails_helper'

RSpec.describe 'supermarkets/:id', type: :feature do
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
  let!(:frank) { Customer.create!(name: 'Frank')}

  let!(:supit1) {CustomerItem.create!(customer: thomas, item: eggs)}
  let!(:supit2) {CustomerItem.create!(customer: thomas, item: bacon)}
  let!(:supit3) {CustomerItem.create!(customer: thomas, item: coffee)}
  let!(:supit4) {CustomerItem.create!(customer: jeff, item: eggs)}
  let!(:supit5) {CustomerItem.create!(customer: jeff, item: steak)}
  let!(:supit6) {CustomerItem.create!(customer: jeff, item: potatoes)}
  let!(:supit7) {CustomerItem.create!(customer: steve, item: potatoes)}
  let!(:supit8) {CustomerItem.create!(customer: steve, item: eggs)}
  let!(:supit9) {CustomerItem.create!(customer: steve, item: coffee)}

  describe 'As a visitor, when I visit a supermarkets show page' do
    it 'I see a unique list of all customers that have shopped there' do
      visit "/supermarkets/#{walmart.id}"

      expect(page).to have_content('Customers:')
      expect(page).to have_content('Thomas').once 
      expect(page).to have_content('Jeff').once 
      expect(page).to have_content('Steve').once 
      expect(page).to_not have_content('Frank') 
    end
  end
end