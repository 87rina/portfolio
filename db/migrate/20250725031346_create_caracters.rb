class CreateCaracters < ActiveRecord::Migration[7.2]
  def change
    create_table :caracters do |t|
      t.string :name
      t.text :system_prompt
      t.string :image_url

      t.timestamps
    end
  end
end
