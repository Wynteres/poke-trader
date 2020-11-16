# frozen_string_literal: true

class BuildTradeFromJson
  def initialize(sent_package_pokemons:, received_package_pokemons:)
    @sent_package_pokemons = sent_package_pokemons
    @received_package_pokemons = received_package_pokemons
  end

  def build
    sent_pokemons = build_pokemons_from(@sent_package_pokemons)
    received_pokemons = build_pokemons_from(@received_package_pokemons)
    sent_package = build_trade_package_from(sent_pokemons)
    received_package = build_trade_package_from(received_pokemons)
    build_trade_from(sent_package, received_package)
  end

  private

  def build_pokemons_from(pokemon_json_list)
    pokemon_json_list.map do |pokemon_json|
      pokemon_attributes = JSON.parse(pokemon_json)
      Pokemon.new(pokemon_attributes)
    end
  end

  def build_trade_package_from(pokemon_list)
    trade_package = TradePackage.new
    trade_package.pokemons << pokemon_list

    trade_package
  end

  def build_trade_from(sent_trade_package, received_trade_package)
    Trade.new(
      sent_package: sent_trade_package,
      received_package: received_trade_package
    )
  end
end
