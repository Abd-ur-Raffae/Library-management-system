class AddAuthorToBooks < ActiveRecord::Migration[8.0]
  def change
    add_reference :books, :author, null: false, foreign_key: true
  end
end
