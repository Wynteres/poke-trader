require 'rails_helper'

RSpec.describe PokemonAdapter do
  describe '#list' do
    describe 'when the list is empty' do
      it 'returns an empty array' do
        params = { pokemons_data: [] }

        result = described_class.list(params)

        expect(result).to be_empty
      end
    end

    describe 'when the list is nil' do
      it 'returns an empty array' do
        params = { pokemons_data: nil }

        expect { described_class.list(params) }.to raise_error(NoMethodError)
      end
    end

    describe 'when the list contains valid pokemon' do
      it 'returns an array with valid pokemons instances' do
        params = {
          pokemons_data: [
            {
              name: 'poke 1',
              url: 'url.com/1'
            }.stringify_keys,
            {
              name: 'poke 2',
              url: 'url.com/2'
            }.stringify_keys
          ]
        }

        first_pokemon_data = {
          name: 'poke 1',
          base_experience: 63,
          sprites: {
            front_default: 'some_path'
          }.stringify_keys
        }.stringify_keys

        second_pokemon_data = {
          name: 'poke 2',
          base_experience: 67,
          sprites: {
            front_default: 'some_path'
          }.stringify_keys
        }.stringify_keys

        allow(Pokemon::Client)
          .to receive(:fetch).with(id: 1).and_return(first_pokemon_data)
        allow(Pokemon::Client)
          .to receive(:fetch).with(id: 2).and_return(second_pokemon_data)

        result = described_class.list(params)
        first_pokemon_instance = result.first
        second_pokemon_instance = result.second

        expect(result.size).to be(2)
        expect(first_pokemon_instance.name).to eq("poke 1")
        expect(first_pokemon_instance.base_experience).to eq(63)
        expect(first_pokemon_instance.image_path).to eq("some_path")

        expect(second_pokemon_instance.name).to eq("poke 2")
        expect(second_pokemon_instance.base_experience).to eq(67)
        expect(second_pokemon_instance.image_path).to eq("some_path")
      end
    end
  end
end
