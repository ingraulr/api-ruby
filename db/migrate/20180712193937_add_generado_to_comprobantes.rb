class AddGeneradoToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_column :comprobantes, :generado, :boolean
  end
end
