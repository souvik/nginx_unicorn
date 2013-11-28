class AddAuthenticatedColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :authenticated, :boolean, null: false, default: false
  end
end
