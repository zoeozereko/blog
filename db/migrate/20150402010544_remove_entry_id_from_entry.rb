class RemoveEntryIdFromEntry < ActiveRecord::Migration
  def change
    remove_column :entries, :entry_id, :string
  end
end
