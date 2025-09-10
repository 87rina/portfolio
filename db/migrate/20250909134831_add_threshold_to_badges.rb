class AddThresholdToBadges < ActiveRecord::Migration[7.2]
  def change
    add_column :badges, :threshold, :integer
  end
end
