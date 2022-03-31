class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :title, null: false
      t.text :body, null: false
      t.boolean :solved, default: false, null: false
      t.integer :user_id

      t.timestamps
    end
  end
end
