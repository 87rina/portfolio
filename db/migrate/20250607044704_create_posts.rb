class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.string :session_id
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
