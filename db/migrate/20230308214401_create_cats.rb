class CreateCats < ActiveRecord::Migration[7.0]
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.string :breed, null: false
      t.integer :weight, null: false
      t.integer :age, null: false
      t.string :image_url, null: false

      t.timestamps

      t.index :name, unique: true
      t.index :breed
      t.index :weight
      t.index :age
    end
  end
end
