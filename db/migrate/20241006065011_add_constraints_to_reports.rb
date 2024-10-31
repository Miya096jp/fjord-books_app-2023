class AddConstraintsToReports < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :reports, :users
    change_column_null :reports, :user_id, false
    add_index :reports, :user_id
  end
end
