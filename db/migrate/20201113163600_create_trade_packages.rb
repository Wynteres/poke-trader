class CreateTradePackages < ActiveRecord::Migration[6.0]
  def change
    create_table :trade_packages do |t|
      t.timestamps
    end
  end
end
