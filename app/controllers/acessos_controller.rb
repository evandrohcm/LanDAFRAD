class AcessosController < ApplicationController

	def index
		@acessos = Acesso.paginate(:page => params[:page], :per_page => 5)

		respond_to do |format|
	      	format.html
	      	format.xml { render :xml => @acessos }
	      	format.json { render :json => @acessos }
    	end
	end

	def new
		@acesso = Acesso.new
	end

	def create
		@acesso = Acesso.new(acesso_params)

		@acesso.save

    	redirect_to '/acessos'
	end

	# Relatórios do HyPDF
	def relatorio_acessos
		html = %Q{
			<html>
			<head>
				<meta charset="UTF-8">
				<title>Relatório dos últimos Acessos</title>

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
				<h1>Relatório dos últimos Acessos da LAN</h1>

				<table style="">
					<thead>
						<tr>
							<th>Id</th>
							<th>Valor</th>
							<th>Duração</th>
							<th>Data do Acesso</th>
							<th>Nome do Cliente</th>
							<th>CPF do Cliente</th>
						</tr>
				    </thead>

				    <tbody>
		}

		Acesso.all.each do |acesso|
			html << %Q{
				<tr>
		    		<td class="vert-align">#{acesso.id}</td>
		    		<td class="vert-align">R$ #{acesso.valor}</td>
		    		<td class="vert-align">#{acesso.duracao} h</td>
		    		<td class="vert-align">#{acesso.created_at.to_time.strftime("%d/%m/%Y") }</td>
		    		<td class="vert-align">#{acesso.cliente.nome}</td>
		    		<td class="vert-align">#{acesso.cliente.cpf}</td>
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

		send_data(hypdf[:pdf], filename: 'relatorio_acessos.pdf', type: 'application/pdf')
	end

	# Privates
	private
		def acesso_params
			params.require(:acesso).permit(:valor, :duracao, :cliente_id)
		end

end
