class CreateProtocols < ActiveRecord::Migration
  def change
    create_table :protocols do |t|
      t.belongs_to :user, null: false
      t.string :name, null: false
      t.text :procedure
      t.string :document
      t.timestamps
    end
  end
end
