class RemoveIndexFromPostsContent < ActiveRecord::Migration
  def change
   remove_index :pages, :content
  end
end
