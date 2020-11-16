# frozen_string_literal: true

class PokemonAdapter
  def self.list(**args)
    new.list(args)
  end

  def list(pokemons_data:)
    pokemons_data.map do |pokemon|
      pokemon_id = pokemon['url'].split('/').last.to_i
      pokemon_attributes = Pokemon::Client.fetch(id: pokemon_id)

      Pokemon.new(filter_attributes(pokemon_attributes))
    end
  end

  private

  def filter_attributes(attributes)
    {
      name: attributes['name'],
      base_experience: attributes['base_experience'],
      image_path: attributes['sprites']['front_default']
    }
  end
end
