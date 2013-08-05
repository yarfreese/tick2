class AddAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :admin, :booleani, default: false
  end
end
