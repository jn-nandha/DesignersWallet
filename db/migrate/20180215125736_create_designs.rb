class CreateDesigns < ActiveRecord::Migration[5.1]
  def change
    create_table :designs do |t|
      t.string :image
      t.text :description
      t.references :user
      t.timestamps
    end
  end
end
