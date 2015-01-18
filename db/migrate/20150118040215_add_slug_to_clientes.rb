class AddSlugToClientes < ActiveRecord::Migration
  def change
    add_column :clientes, :slug, :string
    add_index :clientes, :slug, unique: true
  end
end
