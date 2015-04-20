class AddEntryReferencesToComment < ActiveRecord::Migration
  def change
    add_reference :comments, :entry, index: true, foreign_key: true
  end
end
