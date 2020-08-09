class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string      :title,      null: false
      t.string      :price,      null: false
      t.text        :text,       null: false
      t.integer     :stock,      null: false
      t.string      :brand
      t.string      :condition,  null: false
      # t.integer     :leadtime,   null: false
      t.references  :category,   foreign_key: true
      t.references  :user,       foreign_key: true
      t.references  :delivery,   foreign_key: true
      t.timestamps
    end
  end
end
