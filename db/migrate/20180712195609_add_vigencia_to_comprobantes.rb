class AddVigenciaToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_column :comprobantes, :vigencia, :boolean
  end
end
