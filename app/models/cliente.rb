class Cliente < ActiveRecord::Base
	extend FriendlyId
	friendly_id :nome, use: [:slugged, :finders]

	validates :nome, format: { with: /\A[a-z A-Z]+\z/, message: "Insira apenas letras e espaços no nome" }
	validates :cpf, format: { with: /\A\d{3}.\d{3}.\d{3}-\d{2}\z/, message: "Insira o CPF no formato \"999.999.999-99\"" }
end
