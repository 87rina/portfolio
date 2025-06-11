class CreateAiResponses < ActiveRecord::Migration[7.2]
  def change
    create_table :ai_responses do |t|
      t.text :content, null: false
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
