# frozen_string_literal: true

json.pokemons @pokemon_list[:pokemons], :name, :base_experience, :image_path

json.next_page @pokemon_list[:next_page]

json.previous_page @pokemon_list[:previous_page]
