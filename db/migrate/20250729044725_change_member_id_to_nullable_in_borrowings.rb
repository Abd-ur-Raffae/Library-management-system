class ChangeMemberIdToNullableInBorrowings < ActiveRecord::Migration[7.0]
  def change
    change_column_null :borrowings, :member_id, true
  end
end
