class CreateCouncils < ActiveRecord::Migration
  def change
    create_table :councils do |t|
      t.string :title
      t.text :description
      
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end
end