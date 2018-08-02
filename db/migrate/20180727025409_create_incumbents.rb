class CreateIncumbents < ActiveRecord::Migration
  def change
    create_table :incumbents do |t|

      t.belongs_to :user, index: true
      t.belongs_to :position, index: true
      
      t.boolean :active, default: false
      t.timestamp :active_at
      
      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.boolean :elected, default: false
      t.timestamp :elected_at

      t.timestamps null: false
    end
  end
end
