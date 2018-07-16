class AddUuidToComprobantes < ActiveRecord::Migration[5.2]
  def change
    add_column :comprobantes, :uuid, :string
  end
end
