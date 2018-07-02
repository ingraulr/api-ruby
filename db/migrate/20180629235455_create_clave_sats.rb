class CreateClaveSats < ActiveRecord::Migration[5.2]
  def change
    create_table :clave_sats do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
