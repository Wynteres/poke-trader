class Pokemon::Client
  POKE_API_URL = ENV['POKE_API_URL']
  QUANTITY_PER_PAGE = 22

  def self.list(**args)
    new.list(args)
  end

  def list(page_index:)
    offset = (page_index - 1) * QUANTITY_PER_PAGE
    response = HTTParty.get("#{POKE_API_URL}?offset=#{offset}&limit=#{QUANTITY_PER_PAGE}")

    {
      next_page: parse_page_number(response['next']),
      previous_page: parse_page_number(response['previous']),
      pokemons: response['results']
    }
  end

  def self.fetch(**args)
    new.fetch(args)
  end

  def fetch(id:)
    HTTParty.get("#{POKE_API_URL}/#{id}")
  end

  private

  def parse_page_number(url)
    return if url.nil?

    uri = URI.parse(url)
    query_params = CGI.parse(uri.query)
    offset = query_params['offset'].first.to_i

    (offset / QUANTITY_PER_PAGE) + 1
  end
end
