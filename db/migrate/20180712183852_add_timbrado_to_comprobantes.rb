class AddTimbradoToComprobantes < ActiveRecord::Migration[5.2]
  def change
    change_column :comprobantes, :timbrado, :boolean
  end
end
