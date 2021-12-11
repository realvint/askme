class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.string :body, null: false
      t.string :answer
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
    add_index :questions, :body, unique: true
  end
end
