class CreatePosVotes < ActiveRecord::Migration
  def change
    create_table :pos_votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :position, index: true
      t.integer :vote_id, index: true

      t.boolean :active, default: false
      t.timestamp :active_at
      
      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.boolean :decline, default: false
      t.timestamp :decline_at
      
      t.timestamps null: false
    end
  end
end
