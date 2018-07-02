class CreateCatalogoObjetos < ActiveRecord::Migration[5.2]
  def change
    create_table :catalogo_objetos do |t|
      t.string :tipo

      t.timestamps
    end
  end
end
