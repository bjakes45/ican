class CreateMotVotes < ActiveRecord::Migration
  def change
    create_table :mot_votes do |t|
      t.string :vote

	    t.belongs_to :user, index: true
      t.belongs_to :post, index: true
      
      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at
      
      t.timestamps null: false
    end
  end
end
