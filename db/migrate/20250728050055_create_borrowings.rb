class CreateBorrowings < ActiveRecord::Migration[8.0]
  def change
    create_table :borrowings do |t|
      t.references :book, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.date :borrowed_date
      t.date :due_date
      t.date :returned_date
      t.string :status

      t.timestamps
    end
  end
end
