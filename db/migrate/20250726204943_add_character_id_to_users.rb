class AddCharacterIdToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :character_id, :bigint
  end
end
