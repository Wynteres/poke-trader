require 'rails_helper'

RSpec.describe Trade do
  describe 'validations' do
    describe 'when experience deviation too high' do
      it 'is invalid' do
        sent_package = build(:trade_package, :high_xp_pokemons)
        received_package = build(:trade_package, :low_xp_pokemons)
        trade = described_class.new(sent_package: sent_package, received_package: received_package)

        expect(trade).not_to be_valid
        expect(trade.errors).to include(:base_experience)
      end
    end

    describe 'when experience deviation is acceptable' do
      it 'is invalid' do
        sent_package = build(:trade_package, :high_xp_pokemons)
        received_package = build(:trade_package, :high_xp_pokemons)
        trade = described_class.new(sent_package: sent_package, received_package: received_package)

        expect(trade).to be_valid
        expect(trade.errors).not_to include(:base_experience)
      end
    end
  end
end
