class CreateCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :courses do |t|
      t.boolean :is_available, default: false, null: false
      t.integer :category_id, null: false
      t.integer :duration_of_days, null: false
      t.string :title, null: false
      t.text :description
      t.string :url, null: false

      t.timestamps
    end
  end
end
