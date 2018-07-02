class CreateMetodoPagos < ActiveRecord::Migration[5.2]
  def change
    create_table :metodo_pagos do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
