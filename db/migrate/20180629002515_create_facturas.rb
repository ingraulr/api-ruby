class CreateFacturas < ActiveRecord::Migration[5.2]
  def change
    create_table :facturas do |t|
      t.string :folio
      t.datetime :fecha
      t.string :tipo_comprobante
      t.string :lugar_expedicion
      t.string :forma_pago
      t.string :metodo_pago
      t.string :moneda
      t.string :tipo_cambio
      t.integer :subtotal
      t.integer :total

      t.timestamps
    end
  end
end
