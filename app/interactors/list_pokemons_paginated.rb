class ListPokemonsPaginated
  def initialize(page_index:)
    @page_index = page_index
  end

  def fetch_list
    PokemonAdapter.list(page_index: @page_index)
  end
end
