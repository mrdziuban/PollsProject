class AddResponsesIndexes < ActiveRecord::Migration
  def change
    add_index :responses, :choice_id
    add_index :responses, :user_id
  end
end
