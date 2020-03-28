class CreateUrls < ActiveRecord::Migration[6.0]
  def change
    create_table :urls do |t|
      t.string :code,     null: false
      t.string :url,      null: false
      t.integer :visits,  null: false, default: 0
      t.boolean :enabled, null: false, default: true

      t.timestamps
    end
  end
end
