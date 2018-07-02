class CreateCatalogoMonedas < ActiveRecord::Migration[5.2]
  def change
    create_table :catalogo_monedas do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
