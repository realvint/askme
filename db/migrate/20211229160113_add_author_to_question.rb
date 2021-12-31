class AddAuthorToQuestion < ActiveRecord::Migration[6.1]
  def change
    change_table :questions do |t|
      t.belongs_to :author, foreign_key: { to_table: :users, on_delete: :cascade }
    end
  end
end
