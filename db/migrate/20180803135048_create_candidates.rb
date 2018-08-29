class CreateCandidates < ActiveRecord::Migration
  def change
    create_table :candidates do |t|

      t.belongs_to :user, index: true
      t.belongs_to :position, index: true

      t.boolean :deactivate, default: false
      t.timestamp :deactivate_at

      t.timestamps null: false
    end
  end
end
