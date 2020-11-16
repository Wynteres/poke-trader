require 'rails_helper'

RSpec.describe Pokemon::Client, :vcr do
  describe '#list' do
    describe 'when page index exists' do
      it 'returns a hash with pokemon and page info' do
        params = { page_index: 1 }
        result = described_class.list(params)

        expect(result.keys)
          .to contain_exactly(:next_page, :previous_page, :pokemons)
      end

      it 'returns a list with the quantity per page number of pokemons' do
        params = { page_index: 1 }
        result = described_class.list(params)

        expect(result[:pokemons].size)
          .to be(Pokemon::Client::QUANTITY_PER_PAGE)
      end

      it 'returns each pokemon name and info url' do
        params = { page_index: 1 }
        result = described_class.list(params)

        pokemon_sample = result[:pokemons].first

        expect(pokemon_sample.keys)
          .to contain_exactly('name', 'url')
      end
    end

    describe 'when page index does not exists' do
      it 'returns a hash with pokemon and page info' do
        params = { page_index: 0 }
        result = described_class.list(params)

        expect(result.keys)
          .to contain_exactly(:next_page, :previous_page, :pokemons)
      end

      it 'returns a empty list of pokemons ' do
        params = { page_index: 0 }
        result = described_class.list(params)

        expect(result[:pokemons]).to be_empty
      end
    end

    describe 'when poke api url is missing' do
      it 'raises error TypeError' do
        stub_const("#{described_class}::QUANTITY_PER_PAGE", '')
        params = { page_index: 1 }

        expect { described_class.list(params) }.to raise_error(TypeError)
      end
    end

    describe 'when poke api is out of service' do
      it 'raises error' do
        WebMock.stub_request(:any, /pokeapi.co/)
               .to_return(status: [500, 'Internal Server Error'])

        params = { page_index: 1 }

        expect { described_class.list(params) }.to raise_error(KeyError)
      end
    end
  end

  describe '#fetch' do
    describe 'when pokemon id exists' do
      it 'returns a hash with expected attributes' do
        params = { id: 1 }

        response = described_class.fetch(params)

        expect(response.keys).to include('name', 'base_experience', 'sprites')
        expect(response['sprites'].keys).to include('front_default')
      end
    end

    describe 'when pokemon id does not exists' do
      it 'returns a' do
        params = { id: 0 }

        expect { described_class.fetch(params) }
          .to raise_error(Pokemon::Client::PokemonNotFound)

      end
    end

    describe 'when poke api url is missing' do
      it 'raises error TypeError' do
        stub_const("#{described_class}::QUANTITY_PER_PAGE", '')
        params = { page_index: 1 }

        expect { described_class.list(params) }.to raise_error(TypeError)
      end
    end

    describe 'when poke api is out of service' do
      it 'raises error' do
        WebMock.stub_request(:any, /pokeapi.co/)
               .to_return(status: [500, 'Internal Server Error'])

        params = { page_index: 1 }

        expect { described_class.list(params) }.to raise_error(KeyError)
      end
    end
  end
end
