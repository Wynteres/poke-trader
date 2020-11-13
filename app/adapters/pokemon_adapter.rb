module Adapters
  class PokemonAdapter
    def list(page_index)
      pokemons_data = Pokemon::Client.list(page_index)
      pokemons = build_pokemons_from_json(pokemons_data[:pokemons])

      PokemonList.new(
        pokemons: pokemons,
        next_page: pokemons_data[:next_page],
        previous_page: pokemons_data[:previous_page]
      )
    end

    private

    def build_pokemons_from_json(pokemons_json)
      pokemons_json.map do |pokemon|
        pokemon_id = pokemon['url'].split('/').last
        pokemon_attributes = Pokemon::Client.fetch(pokemon_id)

        Pokemon.new(filter_attributes(pokemon_attributes))
      end
    end

    def filter_attributes(attributes)
      {
        name: attributes['name'],
        base_experience: attributes['base_experience'],
        image_path: attributes['sprites']['front_default']
      }
    end
  end
end
