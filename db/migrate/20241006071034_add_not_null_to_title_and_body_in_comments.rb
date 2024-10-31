class AddNotNullToTitleAndBodyInComments < ActiveRecord::Migration[7.0]
  def change
    change_column_null :comments, :title, false
    change_column_null :comments, :body, false
  end
end
