class CreateMembers < ActiveRecord::Migration[8.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.text :address
      t.date :membership_date
      t.string :membership_type
      t.boolean :active

      t.timestamps
    end
  end
end
