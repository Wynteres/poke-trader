require 'rails_helper'

RSpec.describe Api::V1::PokemonsController, type: :controller do
  describe '#list', :vcr do
    render_views

    before :each do
      request.env['HTTP_ACCEPT'] = 'application/json'
    end

    describe 'when no page is passed' do
      it 'returns first page result' do
        get :list
        body = JSON.parse(response.body)
        pokemon_sample = body['pokemons'].first

        # http status
        expect(response).to be_ok

        # quantity of pokemons per page
        expect(body['pokemons'].size).to be(22)

        # pokemon structure
        expect(pokemon_sample.keys)
          .to contain_exactly('name', 'base_experience', 'image_path')

        # pagination
        expect(body['next_page']).to be(2)
        expect(body['previous_page']).to be_nil
      end
    end

    describe 'when the second page is passed' do
      it 'returns second page result' do
        get :list, { params: { page: 2 } }
        body = JSON.parse(response.body)
        pokemon_sample = body['pokemons'].first

        # http status
        expect(response).to be_ok

        # quantity of pokemons per page
        expect(body['pokemons'].size).to be(22)

        # pokemon structure
        expect(pokemon_sample.keys)
          .to contain_exactly('name', 'base_experience', 'image_path')

        # pagination
        expect(body['next_page']).to be(3)
        expect(body['previous_page']).to be(1)
      end
    end

    describe 'when any error occours' do
      it 'returns status 500' do
        allow(ListPokemonsPaginated).to receive(:new).and_raise(StandardError)
        get :list

        expect(response.status).to be(500)
        expect(response.body).to be_empty
      end
    end
  end
end
