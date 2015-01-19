class ClientesController < ApplicationController
	before_action :authenticate_admin!

	def index
		@clientes = Cliente.paginate(:page => params[:page], :per_page => 5).recent_qtd_acesso.all

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
			flash[:aviso] = "insert"
	    	redirect_to '/clientes'
	    else
	      render 'new'
	    end
	end

	def update
		@cliente = Cliente.friendly.find(params[:id])
 
		if @cliente.update(cliente_params)
			flash[:aviso] = "update"
			redirect_to '/clientes'
		else
			render 'edit'
		end
	end

	def destroy
		@cliente = Cliente.friendly.find(params[:id])
	    @cliente.destroy
	 
	 	flash[:aviso] = "delete"
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

	def relatorio_clientes
		html = %Q{
			<html>
			<head>
				<meta charset="UTF-8">
				<title>Relatório dos Clientes cadastrados</title>

				<style>
					table {
						width: 100%;
					}

					table, tr, th, td {
						border: 1px solid black;
						border-collapse: collapse;
					}
				</style>
			</head>
			<body>
				<br>
				<h1>Relatório de todos os Clientes da LAN</h1>

				<table style="">
					<thead>
						<tr>
							<th>Nome</th>
							<th>CPF</th>
							<th>E-mail</th>
							<th>Data de Nascimento</th>
							<th>Quantidade de Acessos</th>
						</tr>
				    </thead>

				    <tbody>
		}

		Cliente.recent_qtd_acesso.all.each do |cliente|
			html << %Q{
				<tr>
		    		<td class="vert-align">#{cliente.nome}</td>
		    		<td class="vert-align">#{cliente.cpf}</td>
		    		<td class="vert-align">#{cliente.email} h</td>
		    		<td class="vert-align">#{cliente.data_nasc.to_time.strftime("%d/%m/%Y") }</td>
		    		<td class="vert-align">#{cliente.qtd_acesso}</td>
		    	</tr>
			}
		end

		html << %Q{
				</tbody>
			</table>
		</body>
		</html>
		}

		hypdf = HyPDF.htmltopdf(
		    html,
		    test: true
		)

		send_data(hypdf[:pdf], filename: 'relatorio_clientes.pdf', type: 'application/pdf')
	end

	# Testes do Postmark
	def email_send
		ClienteMailer.welcome_message.deliver!
		render plain: "E-mail enviado com sucesso!"
	end

	# Privates
	private
		def cliente_params
			params.require(:cliente).permit(:nome, :cpf, :data_nasc, :email)
		end
end
