class CreateTryusers < ActiveRecord::Migration[5.1]
  def change
    create_table :tryusers do |t|

      t.timestamps
    end
  end
end
