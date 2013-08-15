class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, nil: false, default: '', limit: 60
      t.string :middle_name, nil: false, default: '', limit: 60
      t.string :last_name, nil: false, default: '', limit: 60
      t.string :email, nil:false, default: '', limit: 100
      t.string :encrypted_password, nil: false, default: '', limit: 255
      t.string :zip_code, nil: false, default: '', limit: 10
      t.string :location, nil: false, default: '', limit: 20
      t.timestamps
    end
  end
end
