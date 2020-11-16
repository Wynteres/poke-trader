require 'rails_helper'

RSpec.describe ListPokemonsPaginated do
  describe '#new' do
    describe 'when passing right params' do
      it 'returns described class instance without raise error' do
        right_params = {
          page_index: 1
        }
        expect { described_class.new(right_params) }.not_to raise_error
      end
    end

    describe 'when passing wrong params' do
      it 'raise argument error' do
        right_params = {}
        expect { described_class.new(right_params) }
          .to raise_error(ArgumentError)
      end
    end
  end

  describe '#fetch_list', :vcr do
    subject(:list_pokemons_paginated_instance) { described_class.new(params) }

    describe 'when the page is valid' do
      let(:params) { { page_index: 1 } }

      it 'returns a hash' do
        list_with_pages = list_pokemons_paginated_instance.fetch_list

        expect(list_with_pages.keys)
          .to contain_exactly(:pokemons, :next_page, :previous_page)
        expect(list_with_pages[:next_page]).to be(2)
        expect(list_with_pages[:previous_page]).to be(nil)
        expect(list_with_pages[:pokemons].first.class).to be(Pokemon)
      end
    end

    describe 'when the page is invalid' do
      let(:params) { { page_index: 0 } }

      it 'returns no pokemons' do
        list_with_pages = list_pokemons_paginated_instance.fetch_list

        expect(list_with_pages.keys)
          .to contain_exactly(:pokemons, :next_page, :previous_page)
        expect(list_with_pages[:pokemons]).to be_empty
      end
      it 'returns next page as 1' do
        list_with_pages = list_pokemons_paginated_instance.fetch_list

        expect(list_with_pages.keys)
          .to contain_exactly(:pokemons, :next_page, :previous_page)
        expect(list_with_pages[:next_page]).to be(1)
      end
    end
  end
end
