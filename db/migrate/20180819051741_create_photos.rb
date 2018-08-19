class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.belongs_to :recipe

      t.integer :recipe_id
      t.string :path

      t.timestamps
    end
  end
end
