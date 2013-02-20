class AddIndexesToUsers < ActiveRecord::Migration
  def change
  	add_index :users, :user_name
  	add_index :friendships, :user_id
  	add_index :friendships, :friend_id 	
  	add_index :flits, :user_id
  end
end
