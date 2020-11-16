# frozen_string_literal: true

class Pokemon::Client
  POKE_API_URL = ENV['POKE_API_URL']
  QUANTITY_PER_PAGE = 22

  class PokemonNotFound < StandardError; end

  def self.list(**args)
    new.list(args)
  end

  def list(page_index:)
    offset = (page_index - 1) * QUANTITY_PER_PAGE

    response = HTTParty.get("#{POKE_API_URL}?offset=#{offset}&limit=#{QUANTITY_PER_PAGE}")

    {
      next_page: parse_page_number(response.fetch('next')),
      previous_page: parse_page_number(response.fetch('previous')),
      pokemons: response.fetch('results')
    }
  end

  def self.fetch(**args)
    new.fetch(args)
  end

  def fetch(id:)
    response = HTTParty.get("#{POKE_API_URL}/#{id}")

    raise PokemonNotFound unless response.success?

    response
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
