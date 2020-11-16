require 'rails_helper'

RSpec.describe Api::V1::TradesController, type: :controller do
  describe('#validate') do
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
          }.to_json
        }

        expect { get :validate, params: params }
          .not_to raise_error
        expect(response.status).to be(500)
        expect(response.body).to be_empty
      end
    end

    describe 'when all params are valid' do

      it 'returns a json with a key "valid"' do
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
          }.to_json
        }

        get :validate, params: params

        expect(response).to be_ok
        expect(JSON.parse(response.body)).to eq({ 'valid' => true })
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
          }.to_json
        }

        get :validate, params: params

        expect(response).to be_ok
        expect(JSON.parse(response.body)).to eq({ 'valid' => false })
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
          }.to_json
        }

        get :validate, params: params

        expect(response).to be_ok
        expect(JSON.parse(response.body)).to eq({ 'valid' => false })
      end
    end
  end
end
