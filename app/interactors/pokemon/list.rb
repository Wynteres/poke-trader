class Interactors::Pokemon::List
  def initialize(page_index:)
    @page_index = page_index
  end

  def fetch_list_by_page
    Adapters::PokemonAdapter.list(@page_index)
  end
end
