class CreateAuthors < ActiveRecord::Migration[8.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.text :biography
      t.date :birth_date
      t.string :nationality

      t.timestamps
    end
  end
end
