require 'rails_helper'

RSpec.describe TradePackage do
  describe 'validations' do
    describe 'when there is more than 6 pokemons' do
      it 'is invalid' do
        package_pokemons = (0..6).map { |_| build(:pokemon) }

        trade_package_instance = described_class.new(pokemons: package_pokemons)

        expect(package_pokemons.size).to be(7)
        expect(trade_package_instance).not_to be_valid
        expect(trade_package_instance.errors).to include(:pokemons)
      end
    end

    describe 'when there is zero pokemons' do
      it 'is invalid' do
        trade_package_instance = described_class.new(pokemons: [])

        expect(trade_package_instance.pokemons.size).to be_zero
        expect(trade_package_instance).not_to be_valid
        expect(trade_package_instance.errors).to include(:pokemons)
      end
    end

    describe 'when there is between 1 and 6' do
      it 'is invalid' do
        package_pokemons = (0..3).map { |_| build(:pokemon) }

        trade_package_instance = described_class.new(pokemons: package_pokemons)

        expect(package_pokemons.size).to be(4)
        expect(trade_package_instance).to be_valid
      end
    end
  end

  describe '#total_pokemons_experience' do
    describe 'when there is pokemons' do
      it 'return the total value of XP' do
        package_pokemons = (0..3).map { |_| build(:pokemon, base_experience: 10) }

        trade_package_instance = described_class.new(pokemons: package_pokemons)

        expect(trade_package_instance.total_pokemons_experience).to be(40)
      end
    end

    describe 'when there is no pokemons' do
      it 'return 0' do
        trade_package_instance = described_class.new(pokemons: [])

        expect(trade_package_instance.total_pokemons_experience).to be(0)
      end
    end
  end
end
