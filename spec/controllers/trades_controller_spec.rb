require 'rails_helper'

RSpec.describe TradesController, type: :controller do
  describe '#create' do
    describe 'when there is missing params' do
      it 'raise error' do
        params = {
          trade: {
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              },
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }
            ]
          }
        }

        expect { post :create, params: params }
          .to raise_error(ArgumentError)
      end
    end

    describe 'when all params are valid' do
      it 'redirect to home with success message' do
        params = {
          trade: {
            sent_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 2,
                name: 'Monstro de bolso 2',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 3,
                name: 'Monstro de bolso 3',
                base_experience: 10,
                image_path: 'path'
              }.to_json

            ],
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }.to_json
            ]
          }
        }

        expect { post :create, params: params }
          .to change { Trade.all.size }.from(0).to(1)

        expect(response).to be_redirect
        expect(response).to redirect_to(root_path)
      end
    end

    describe 'when the base experience deviation is too high' do
      it 'stays in new page with error message' do
        params = {
          trade: {
            sent_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 300,
                image_path: 'path'
              }.to_json,
              {
                id: 2,
                name: 'Monstro de bolso 2',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 3,
                name: 'Monstro de bolso 3',
                base_experience: 10,
                image_path: 'path'
              }.to_json

            ],
            received_package_pokemons: [
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }.to_json
            ]
          }
        }

        expect { post :create, params: params }
          .to_not change { Trade.all.size }.from(0)
        expect(response).to be_successful
        expect(response).to render_template('trades/new')
        expect(flash[:danger])
          .to eq('Er... Equipe rocket? Verifique sua troca, algo está errado!')
      end
    end

    describe 'when the pokemon quantity is not within 1 to 6 range' do
      it 'stays in new page with error message' do
        params = {
          trade: {
            sent_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 10,
                image_path: 'path'
              }.to_json
            ],
            received_package_pokemons: [
              {
                id: 1,
                name: 'Monstro de bolso 1',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 2,
                name: 'Monstro de bolso 2',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 3,
                name: 'Monstro de bolso 3',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 4,
                name: 'Monstro de bolso 4',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 5,
                name: 'Monstro de bolso 5',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 6,
                name: 'Monstro de bolso 6',
                base_experience: 10,
                image_path: 'path'
              }.to_json,
              {
                id: 7,
                name: 'Monstro de bolso 7',
                base_experience: 10,
                image_path: 'path'
              }.to_json
            ]
          }
        }

        expect { post :create, params: params }
          .to_not change { Trade.all.size }.from(0)

        expect(response).to be_successful
        expect(response).to render_template('trades/new')
        expect(flash[:danger])
          .to eq('Er... Equipe rocket? Verifique sua troca, algo está errado!')
      end
    end
  end
end
