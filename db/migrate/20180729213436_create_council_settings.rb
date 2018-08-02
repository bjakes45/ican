class CreateCouncilSettings < ActiveRecord::Migration
  def change
    create_table :council_settings do |t|

      t.belongs_to :user, index: true
      t.belongs_to :council, index: true
      
      t.integer :memb_vote_threshold, default: 50

      t.integer :min_mot_vote, default: 10
      
      t.integer :campaign_length, default: 30

      t.integer :enactment_delay, default: 45

      t.string :membership_area, default: 'Global'
      
      t.string :membership_distance

      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.timestamps null: false
    end
  end
end
