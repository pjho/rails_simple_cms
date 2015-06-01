class AddSudoToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :sudo, :boolean, default: false
  end
end
