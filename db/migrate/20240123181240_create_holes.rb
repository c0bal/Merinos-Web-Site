class CreateHoles < ActiveRecord::Migration[7.0]
  def change
    create_table :holes do |t|
      t.references :round, null: false, foreign_key: true
      t.integer :number
      t.integer :score

      t.timestamps
    end
  end
end