class CreateMentions < ActiveRecord::Migration[7.0]
  def change
    create_table :mentions do |t|
      t.integer :mention_id, null: false
      t.integer :mentioned_id, null: false

      t.timestamps
    end
    add_index :mentions, :mention_id
    add_index :mentions, :mentioned_id
    add_index :mentions, [:mention_id, :mentioned_id], unique: true
  end
end
