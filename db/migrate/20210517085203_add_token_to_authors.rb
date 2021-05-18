class AddTokenToAuthors < ActiveRecord::Migration[6.0]
  def change
    add_column :authors, :authentication_token, :string, limit: 30
    add_index :authors, :authentication_token, unique: true
  end
end
