class CreateBooks < ActiveRecord::Migration[8.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :isbn
      t.integer :publication_year
      t.string :genre
      t.text :description
      t.boolean :available

      t.timestamps
    end
  end
end
