class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.string :color, default: "#C4C4C4"

      t.timestamps null: false
    end
  end
end
