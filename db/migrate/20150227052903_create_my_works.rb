class CreateMyWorks < ActiveRecord::Migration
  def change
    create_table :my_works do |t|
      t.string :title
      t.string :tags
      t.text :description
      t.integer :picture_id
      t.boolean :published, default: false

      t.timestamps null: false
    end
  end
end
