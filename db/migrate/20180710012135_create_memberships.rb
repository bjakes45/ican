class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      
      t.belongs_to :user, index: true
      t.belongs_to :council, index: true
      
      t.boolean :active, default: false
      t.timestamp :active_at
      
      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.timestamps null: false
    end
  end
end
