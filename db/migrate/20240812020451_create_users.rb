class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: true
      t.string :password_digest, null: false
      t.integer :status, null: false, default: 1
      t.integer :iat

      t.timestamps
      t.index [ :email ], unique: true
    end
  end
end
