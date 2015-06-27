class CreateTagsImages < ActiveRecord::Migration
  def change
    create_table :tags_images do |t|
      t.references :tag
      t.references :image

      t.timestamps null: false
    end
    add_index :tags_images, :tag_id
    add_index :tags_images, :image_id
  end
end
