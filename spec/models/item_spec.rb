require 'rails_helper'

RSpec.describe Item, type: :model do
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

  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many(:customer_items) }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe 'instance methods' do
    describe '#customer_count' do
      it 'returns an integer of the customers who purchased the item' do
        expect(eggs.customer_count).to eq(3)
        expect(bacon.customer_count).to eq(1)
        expect(potatoes.customer_count).to eq(2)
        expect(beer.customer_count).to eq(0)
      end
    end
  end
end
