class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
	    t.string :title
      t.text :description
      
      t.belongs_to :user, index: true
      t.belongs_to :council, index: true

      t.boolean :active, default: false
      t.timestamp :active_at
      
      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.boolean :appointed, default: false

      t.timestamps null: false
    end
  end
end
