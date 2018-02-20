class CreateJoinTableDesignsCategories < ActiveRecord::Migration[5.1]
  def change
    create_join_table :designs, :categories do |t|
      # t.index [:design_id, :category_id]
      # t.index [:category_id, :design_id]
    end
  end
end
