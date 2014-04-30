class RenameOmniauthColumnsInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :uid, :provider_id
    rename_column :users, :provider, :provider_type
  end
end
