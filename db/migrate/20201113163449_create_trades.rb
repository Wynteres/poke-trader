class CreateTrades < ActiveRecord::Migration[6.0]
  def change
    create_table :trades do |t|
      t.bigint :sent_package_id, foreign_key: true
      t.bigint :received_package_id, foreign_key: true

      t.timestamps
    end

    add_index :trades, :sent_package_id
    add_index :trades, :received_package_id
  end
end
