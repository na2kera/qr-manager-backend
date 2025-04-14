class CreateQrcodes < ActiveRecord::Migration[8.0]
  def change
    create_table :qrcodes do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, null: false
      t.string :url, null: false
      t.timestamps
    end

    add_index :qrcodes, [:user_id, :title], unique: true
  end
end 