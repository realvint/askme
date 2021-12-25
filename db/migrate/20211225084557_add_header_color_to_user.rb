class AddHeaderColorToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :header_color, :string
  end
end
