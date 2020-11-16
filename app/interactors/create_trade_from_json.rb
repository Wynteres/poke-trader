# frozen_string_literal: true

class CreateTradeFromJson
  def initialize(sent_package_pokemons:, received_package_pokemons:)
    @trade_params = {
      sent_package_pokemons: sent_package_pokemons,
      received_package_pokemons: received_package_pokemons
    }
  end

  def create
    trade = BuildTradeFromJson.new(@trade_params).build

    return trade unless trade.valid?

    trade.save
    trade
  end
end
