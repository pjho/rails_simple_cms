class AddIndexToPages < ActiveRecord::Migration
  def change
    # add_column :pages, :content, :string
    add_index :pages, :content, unique: true
  end
end
