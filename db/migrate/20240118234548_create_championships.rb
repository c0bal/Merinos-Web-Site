class CreateChampionships < ActiveRecord::Migration[7.0]
  def change
    create_table :championships do |t|
      t.string :name

      t.timestamps
    end

    create_table :championships_users, id: false do |t|
      t.belongs_to :championship
      t.belongs_to :user
    end
  end
end
