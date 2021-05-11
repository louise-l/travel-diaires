class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :description
      t.string :url_cover_picture
      t.float :score
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
