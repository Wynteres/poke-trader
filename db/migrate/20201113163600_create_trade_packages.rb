class CreateTradePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_packages do |t|
      t.references :trade, foreign_key: true

      t.timestamps
    end
  end
end
