class CreateThresholds < ActiveRecord::Migration[5.2]
  def change
    create_table :thresholds do |t|
      t.integer :threshold
      t.timestamps
    end
  end
end