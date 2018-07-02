class CreateCatalogoAmbientes < ActiveRecord::Migration[5.2]
  def change
    create_table :catalogo_ambientes do |t|
      t.string :ambiente

      t.timestamps
    end
  end
end
