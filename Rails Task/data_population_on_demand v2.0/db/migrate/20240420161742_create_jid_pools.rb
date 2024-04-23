class CreateJidPools < ActiveRecord::Migration[5.2]
  def change
    create_table :jid_pools do |t|
      t.string :jid
      t.boolean :is_used, default: false
      t.timestamps
    end
  end
end