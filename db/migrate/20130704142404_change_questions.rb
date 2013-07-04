class ChangeQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :user_id, :poll_id
  end
end
