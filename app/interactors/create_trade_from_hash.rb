class CreateTradeFromHash
  def initialize(sent_package_pokemons:, received_package_pokemons:)
    @sent_package_pokemons = sent_package_pokemons
    @received_package_pokemons = received_package_pokemons
  end

  def create
    sent_pokemons = build_pokemons_from(@sent_package_pokemons)
    received_pokemons = build_pokemons_from(@received_package_pokemons)
    sent_package = build_trade_package_from(sent_pokemons)
    received_package = build_trade_package_from(received_pokemons)
    trade = build_trade_from(sent_package, received_package)

    return trade unless validate_trade(trade)

    trade.save
    trade
  end

  private

  def build_pokemons_from(pokemon_hash_list)
    pokemon_hash_list.map do |pokemon_attributes|
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

  def validate_trade(trade)
    trade.valid?
  end
end