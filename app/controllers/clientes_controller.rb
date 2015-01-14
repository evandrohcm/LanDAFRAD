class ClientesController < ApplicationController

	def index
		@clientes = Cliente.all
	end

	def show
		@cliente = Cliente.find(params[:id])
	end

	def new
		@cliente = Cliente.new
	end

	def edit
		@cliente = Cliente.find(params[:id])
	end

	def create
		# Cria hash com os valores default, e junta com os parâmetros passados pelo POST
		defaults = {:qtd_acesso => 0, :bonus_acumulado => 0, :horas_gratis => 0}
		valores = defaults.merge(cliente_params)

		@cliente = Cliente.new(valores)
		if @cliente.save
			flash[:aviso_cadastrar] = true
	    	redirect_to '/clientes'
	    else
	      render 'new'
	    end
	end

	def update
		@cliente = Cliente.find(params[:id])
 
		if @cliente.update(cliente_params)
			flash[:aviso_atualizar] = true
			redirect_to '/clientes'
		else
			render 'edit'
		end
	end

	def destroy
		@cliente = Cliente.find(params[:id])
	    @cliente.destroy
	 
	 	flash[:aviso_deletar] = true
	    redirect_to '/clientes'
	end

	private
		def cliente_params
			params.require(:cliente).permit(:nome, :cpf, :data_nasc, :email)
		end
end
