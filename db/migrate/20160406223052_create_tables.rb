class CreateTables < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :zipcode, null: false
      t.string :telephone, null: false
      t.string :webpage
    end

    create_table :orders do |t|
      t.belongs_to :vendor, null: false
      t.belongs_to :user, null: false
      t.timestamps null: false
      t.string :po_number
      t.boolean :ordered, default: false
    end

    create_table :items do |t|
      t.belongs_to :order, null: false
      t.integer :quantity, null: false
      t.string :cat_number, null: false
      t.string :url
      t.string :size
      t.decimal :price, null: false
      t.string :product_name, null: false
    end
  end
end
