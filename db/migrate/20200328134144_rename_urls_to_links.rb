class RenameUrlsToLinks < ActiveRecord::Migration[6.0]
  def change
    rename_table :urls, :links
  end
end
