class CreatePokemons < ActiveRecord::Migration[6.0]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :base_experience
      t.string :image_path

      t.references :trade_package, foreign_key: true

      t.timestamps
    end
  end
end
