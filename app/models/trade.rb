# frozen_string_literal: true

class Trade < ApplicationRecord
  MAXIMUM_XP_DEVIATION_ACCEPTABLE = 64

  belongs_to :sent_package, class_name: 'TradePackage', validate: true
  belongs_to :received_package, class_name: 'TradePackage', validate: true

  validate :packages_experience_deviation

  private

  def packages_experience_deviation
    xp_to_be_sent = sent_package.total_pokemons_experience
    xp_to_be_received = received_package.total_pokemons_experience
    xp_deviation = (xp_to_be_sent - xp_to_be_received).abs

    if xp_deviation >= MAXIMUM_XP_DEVIATION_ACCEPTABLE
      errors.add(:base_experience, 'A diferença de experiencia entre os inventários é grande demais')
    end
  end
end
