class AddOmniauthToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :image, :string
    add_column :users, :uid, :string
  end
end
