class CreateAcessos < ActiveRecord::Migration
  def change
    create_table :acessos do |t|
      t.float :valor
      t.integer :duracao
      t.references :cliente, index: true

      t.timestamps
    end
  end
end
