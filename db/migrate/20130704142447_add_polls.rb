class AddPolls < ActiveRecord::Migration
  def change
    create_table :polls do |t|
      t.integer :user_id
    end
  end
end
