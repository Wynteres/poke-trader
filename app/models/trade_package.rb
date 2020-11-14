class TradePackage < ApplicationRecord
  has_many :pokemons, validate: true

  validates :pokemons, length: {
    minimum: 1,
    maximum: 6,
    message: 'Uma troca deve ter entre 1 e 6 pokemons de cada lado'
  }

  def total_pokemons_experience
    pokemons.sum(&:base_experience)
  end
end
