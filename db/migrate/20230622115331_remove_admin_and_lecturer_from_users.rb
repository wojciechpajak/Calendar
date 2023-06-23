class RemoveAdminAndLecturerFromUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :admin, :boolean
    remove_column :users, :lecturer, :boolean
  end
end
