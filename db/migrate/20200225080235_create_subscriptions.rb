class CreateSubscriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.integer :course_id
      t.datetime :start_at
      t.datetime :end_at

      t.timestamps
    end
  end
end
