class CreateCouncils < ActiveRecord::Migration
  def change
    create_table :councils do |t|
      t.string :title
      t.text :description

      t.string :country
      t.string :state
      t.string :city
      
      t.belongs_to :user, index: true
      t.belongs_to :council_category, index: true

      t.timestamps null: false
    end
  end
end