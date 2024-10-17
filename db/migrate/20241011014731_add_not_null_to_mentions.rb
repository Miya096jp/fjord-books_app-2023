class AddNotNullToMentions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :mentions, :mention_id, false
    change_column_null :mentions, :mentioned_id, false
  end
end
