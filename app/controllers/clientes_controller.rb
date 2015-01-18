class ClientesController < ApplicationController

	def index
		@clientes = Cliente.paginate(:page => params[:page], :per_page => 5)

		respond_to do |format|
	      	format.html
	      	format.xml { render :xml => @clientes }
	      	format.json { render :json => @clientes }
    	end
	end

	def show
		@cliente = Cliente.friendly.find(params[:id])

		respond_to do |format|
	      	format.html
	      	format.xml { render :xml => @cliente.to_xml }
	      	format.json { render :json => @cliente.to_json }
    	end
	end

	def new
		@cliente = Cliente.new
	end

	def edit
		@cliente = Cliente.friendly.find(params[:id])
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
		@cliente = Cliente.friendly.find(params[:id])
 
		if @cliente.update(cliente_params)
			flash[:aviso_atualizar] = true
			redirect_to '/clientes'
		else
			render 'edit'
		end
	end

	def destroy
		@cliente = Cliente.friendly.find(params[:id])
	    @cliente.destroy
	 
	 	flash[:aviso_deletar] = true
	    redirect_to '/clientes'
	end

	# Testes do HyPDF
	def htmltopdf
		hypdf = HyPDF.htmltopdf(
		    '<html><body><h1>Teste HyPDF</h1></body></html>',
		    test: true
		)

		send_data(hypdf[:pdf], filename: 'hypdf_test.pdf', type: 'application/pdf')
	end

	# Privates
	private
		def cliente_params
			params.require(:cliente).permit(:nome, :cpf, :data_nasc, :email)
		end
end
