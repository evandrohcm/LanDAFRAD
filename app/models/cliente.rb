class Cliente < ActiveRecord::Base
	validates :nome, format: { with: /\A[a-zA-Z]+\z/, message: "Insira apenas letras no nome" }
	validates :cpf, format: { with: /\A\d{3}.\d{3}.\d{3}-\d{2}\z/, message: "Insira o CPF no formato \"999.999.999-99\"" }
end
