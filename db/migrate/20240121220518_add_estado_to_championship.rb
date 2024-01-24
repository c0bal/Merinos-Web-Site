class AddEstadoToChampionship < ActiveRecord::Migration[7.0]
  def change
    add_column :championships, :estado, :string
  end
end
