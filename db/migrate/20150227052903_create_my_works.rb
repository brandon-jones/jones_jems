class CreateMyWorks < ActiveRecord::Migration
  def change
    create_table :my_works do |t|
      t.string :title
      t.string :tags
      t.text :description
      t.integer :cover

      t.timestamps null: false
    end
  end
end
