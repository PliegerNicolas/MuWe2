class AddFirstNameAndLastActivityToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_activity, :datetime
  end
end
