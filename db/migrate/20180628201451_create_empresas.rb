class CreateEmpresas < ActiveRecord::Migration[5.2]
  def change
    create_table :empresas do |t|
      t.string :empresa_uid
      t.string :empresa_api_key
      t.string :ambiente
      t.string :objeto
      t.string :certificado_pem
      t.string :llave_pem
      t.string :llave_password

      t.timestamps
    end
  end
end
