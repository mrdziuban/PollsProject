class AddPollsTeamId < ActiveRecord::Migration
  def change
    add_column :polls, :team_id, :integer
    add_index :polls, :team_id
  end
end
