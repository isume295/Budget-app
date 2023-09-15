class CreateJoinTableExchangeCategory < ActiveRecord::Migration[7.0]
  def change
    create_join_table :categories, :exchanges do |t|
      t.index [:category_id, :exchange_id]
      t.index [:exchange_id, :category_id]
    end
  end
end
