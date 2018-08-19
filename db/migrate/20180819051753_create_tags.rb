class CreateTags < ActiveRecord::Migration[5.2]
  def change
    create_table :tags do |t|
      t.belongs_to :recipe

      t.string :name
      t.integer :recipe_id

      t.timestamps
    end
  end
end
