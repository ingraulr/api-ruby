class CreateRegimenFiscals < ActiveRecord::Migration[5.2]
  def change
    create_table :regimen_fiscals do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
