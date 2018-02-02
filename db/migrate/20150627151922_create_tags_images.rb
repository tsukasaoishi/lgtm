class CreateTagsImages < ActiveRecord::Migration[5.1]
  def change
    create_table :tags_images do |t|
      t.references :tag
      t.references :image

      t.timestamps null: false
    end
  end
end
