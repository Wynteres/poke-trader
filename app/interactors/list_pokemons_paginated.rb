# frozen_string_literal: true

class ListPokemonsPaginated
  def initialize(page_index:)
    @page_index = page_index
  end

  def fetch_list
    result = Pokemon::Client.list(page_index: @page_index)
    pokemon_list = PokemonAdapter.list(pokemons_data: result[:pokemons])

    {
      pokemons: pokemon_list,
      next_page: result[:next_page],
      previous_page: result[:previous_page]
    }
  end
end
