class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nome
      t.string :cpf
      t.date :data_nasc
      t.integer :qtd_acesso
      t.float :bonus_acumulado
      t.integer :horas_gratis

      t.timestamps
    end
  end
end
