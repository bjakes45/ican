class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      
      t.belongs_to :user, index: true
      t.belongs_to :council, index: true

      t.boolean :closed, default: true
      t.boolean :motion, default: false

      t.timestamps null: false
    end
  end
end
