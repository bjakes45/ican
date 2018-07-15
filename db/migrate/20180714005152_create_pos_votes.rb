class CreatePosVotes < ActiveRecord::Migration
  def change
    create_table :pos_votes do |t|
      t.belongs_to :user, index: true
      t.belongs_to :position, index: true
      t.integer :vote_id, index: true

      t.boolean :active, default: false

      t.timestamps null: false
    end
  end
end
