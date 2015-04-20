class AddCommentReferencesToEntry < ActiveRecord::Migration
  def change
    add_reference :entries, :entry, index: true, foreign_key: true
  end
end
