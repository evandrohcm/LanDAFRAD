class AcessosController < ApplicationController

	def index
		@acessos = Acesso.paginate(:page => params[:page], :per_page => 5)
	end

	def new
		@acesso = Acesso.new
	end

	def create
		@acesso = Acesso.new(acesso_params)

		@acesso.save

    	redirect_to '/acessos'
	end

	# Privates
	private
		def acesso_params
			params.require(:acesso).permit(:valor, :duracao, :cliente_id)
		end

end
