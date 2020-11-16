FactoryBot.define do
  factory :trade_package do
    trait :high_xp_pokemons do
      pokemons { (1..4).map { |_| build(:pokemon, base_experience: 250) } }
    end

    trait :low_xp_pokemons do
      pokemons { (1..4).map { |_| build(:pokemon, base_experience: 64) } }
    end

    trait :too_many_pokemons do
      pokemons { (1..7).map { |_| build(:pokemon) } }
    end
  end
end
