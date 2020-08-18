class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.integer     :zipcode,     null:false
      t.string      :area,        null:false
      t.string      :city,        null:false
      t.text        :street,      null:false
      t.references  :user,        foreign_key: true
      t.timestamps
    end
  end
end
