class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      
      t.integer :parent_post_id, null: true

      t.belongs_to :user, index: true
      t.belongs_to :council, index: true

      t.boolean :closed, default: true
      
      t.boolean :motion, default: false

      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at
      
      t.timestamps null: false
    end
  end
end
