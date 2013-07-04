class AddResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.string :response
      t.integer :choice_id
      t.integer :user_id
    end
  end
end
