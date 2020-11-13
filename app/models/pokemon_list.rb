class PokemonList
  attr_reader :pokemons, :next_page, :previous_page

  def initialize(pokemons:, next_page:, previous_page:)
    @pokemons = pokemons
    @next_page = next_page
    @previous_page = previous_page
  end
end
