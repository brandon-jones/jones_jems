class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.boolean :admin, default: false
      t.boolean :receive_emails, default: false

      t.timestamps null: false
    end

    add_index :users, :email
  end
end
