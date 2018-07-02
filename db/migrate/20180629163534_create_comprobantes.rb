class CreateComprobantes < ActiveRecord::Migration[5.2]
  def change
    create_table :comprobantes do |t|
      t.string :empresa_uid
      t.string :empresa_api_key
      t.string :ambiente
      t.string :objeto
      t.string :certificado_pem
      t.string :llave_pem
      t.string :llave_password
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
      t.string :rfc_emisor
      t.string :nombre_emisor
      t.string :regimen_fiscal_emisor
      t.string :rfc_receptor
      t.string :nombre_receptor
      t.string :uso_cfdi
      t.string :clave_producto_servicio
      t.string :clave_unidad
      t.integer :cantidad
      t.text :descripcion
      t.integer :valor_unitario
      t.integer :importe
      t.string :unidad
      t.string :no_identificacion
      t.integer :base
      t.string :impuesto
      t.string :tipo_factor

      t.timestamps
    end
  end
end
