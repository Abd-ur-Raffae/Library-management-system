class RemoveAuthorFromBooks < ActiveRecord::Migration[8.0]
  def change
    remove_column :books, :author, :string
  end
end
