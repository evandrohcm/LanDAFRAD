class ClientesController < ApplicationController

	def new
		
	end

	def create
		# Cria hash com os valores default, e junta com os parâmetros passados pelo POST
		defaults = {:qtd_acesso => 0, :bonus_acumulado => 0, :horas_gratis => 0}
		valores = defaults.merge(cliente_params)

		cliente = Cliente.new(valores)
		cliente.save

		redirect_to '/'
	end

	private
		def cliente_params
			params.require(:cliente).permit(:nome, :cpf, :data_nasc)
		end
end
