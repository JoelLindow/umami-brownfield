class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.float :price
      t.integer :stock_level
      t.string :image
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
