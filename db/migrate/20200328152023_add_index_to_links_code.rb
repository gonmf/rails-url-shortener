class AddIndexToLinksCode < ActiveRecord::Migration[6.0]
  def change
    add_index :links, ['code'], unique: true
  end
end
