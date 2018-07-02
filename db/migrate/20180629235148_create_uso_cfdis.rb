class CreateUsoCfdis < ActiveRecord::Migration[5.2]
  def change
    create_table :uso_cfdis do |t|
      t.string :clave
      t.string :descripcion

      t.timestamps
    end
  end
end
