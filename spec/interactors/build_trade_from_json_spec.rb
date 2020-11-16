require 'rails_helper'

RSpec.describe BuildTradeFromJson do
  describe '#new' do
    describe 'when passing right params' do
      it 'returns described class instance without raise error' do
        right_params = { sent_package_pokemons: [], received_package_pokemons: [] }
        expect { described_class.new(right_params) }.not_to raise_error
      end
    end

    describe 'when passing wrong params' do
      it 'raise argument error' do
        right_params = {}
        expect { described_class.new(right_params) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#build' do
    subject(:build_trade_from_json_instance) { described_class.new(params) }

    describe 'when all params are valid' do
      let(:params) do
        {
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
      end

      it 'returns an unpersisted valid trade instance' do
        result = build_trade_from_json_instance.build

        expect(result.class).to be(Trade)
        expect(result).to be_valid
        expect(result).not_to be_persisted
      end
    end

    describe 'when params are invalid' do
      let(:params) do
        {
          sent_package_pokemons: nil,
          received_package_pokemons: nil
        }
      end

      it 'returns an unpersisted valid trade instance' do
        expect { build_trade_from_json_instance.build }.to raise_error(NoMethodError)
      end
    end
  end
end
