class CreateRecipes < ActiveRecord::Migration[5.2]
  def change
    create_table :recipes do |t|
      t.string :title, index: true
      t.string :description
      t.string :steps
      t.string :ingredients

      t.timestamps
    end
  end
end
