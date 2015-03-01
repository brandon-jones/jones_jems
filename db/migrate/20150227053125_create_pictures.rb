class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
    	t.string :title
      t.string :description
      t.integer :my_work_id
      t.attachment :image
      t.boolean :cropped, default: false

      t.timestamps null: false
    end
  end
end
