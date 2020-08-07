class CreateBuys < ActiveRecord::Migration[6.0]
  def change
    create_table :buys do |t|
      t.text       :text,   null: false
      t.integer    :price,  null: false
      t.references :user,   foreign_key: true
      t.references :item,   foreign_key: true
      t.timestamps
    end
  end
end
