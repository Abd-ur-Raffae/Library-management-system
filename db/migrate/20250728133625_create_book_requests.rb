class CreateBookRequests < ActiveRecord::Migration[7.0]
  def change
    create_table :book_requests do |t|
      t.references :book, null: false, foreign_key: true
      t.references :member, null: true, foreign_key: true
      t.references :requested_by, null: false, foreign_key: { to_table: :users }
      t.date :requested_date
      t.date :needed_by_date
      t.string :status
      t.text :reason
      t.references :approved_by, null: true, foreign_key: { to_table: :users }
      t.date :approved_date
      t.text :rejection_reason

      t.timestamps
    end
  end
end
