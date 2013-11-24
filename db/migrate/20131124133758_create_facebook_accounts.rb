class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.integer :user_id, nil: false, default: 0
      t.string :identifier, nil: false, default: '', limit: 100
      t.string :username, nil: false, default: '', limit: 255
      t.boolean :verified, nil: false, default: false
      t.timestamps
    end
  end
end
