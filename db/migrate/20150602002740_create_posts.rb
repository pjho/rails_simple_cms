class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug, :uniq => true, :null => false 
      t.text :content
      t.boolean :published, index: true, :default => false, :null => false 
      t.timestamps null: false
    end
  end
end
