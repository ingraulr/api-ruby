class CreateFormaPagos < ActiveRecord::Migration[5.2]
  def change
    create_table :forma_pagos do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
