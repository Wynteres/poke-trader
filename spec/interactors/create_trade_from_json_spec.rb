require 'rails_helper'

RSpec.describe CreateTradeFromJson do
  describe '#new' do
    describe 'when passing right params' do
      it 'returns described class instance without raise error' do
        right_params = {
          sent_package_pokemons: [],
          received_package_pokemons: []
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

  describe '#create' do
    subject(:create_trade_from_json_instance) do
      described_class.new(
        {
          sent_package_pokemons: [],
          received_package_pokemons: []
        }
      )
    end

    describe 'when trade build is successful' do
      describe 'when trade is invalid' do
        it 'returns a invalid and unpersisted trade instance' do
          invalid_trade_mock = double(valid?: false)
          allow(invalid_trade_mock).to receive(:save)

          build_trade_from_json_mock = double(build: invalid_trade_mock)
          allow(BuildTradeFromJson).to receive(:new)
            .and_return(build_trade_from_json_mock)

          result = create_trade_from_json_instance.create

          expect(result).not_to be_valid
          expect(invalid_trade_mock).not_to have_received(:save)
        end
      end

      describe 'when trade is valid' do
        it 'returns a valid and persisted trade instance' do
          invalid_trade_mock = double(valid?: true)
          allow(invalid_trade_mock).to receive(:save)

          build_trade_from_json_mock = double(build: invalid_trade_mock)
          allow(BuildTradeFromJson).to receive(:new)
            .and_return(build_trade_from_json_mock)

          result = create_trade_from_json_instance.create

          expect(result).to be_valid
          expect(invalid_trade_mock).to have_received(:save)
        end
      end
    end

    describe 'when trade build is unsuccessful' do
      it 'let the error go up chain' do
        allow(BuildTradeFromJson).to receive(:new).and_raise(StandardError)
        expect { create_trade_from_json_instance.create }
          .to raise_error(StandardError)
      end
    end
  end
end
