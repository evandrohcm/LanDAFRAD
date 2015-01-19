module ClientesHelper
	def alert_title(job)
		retorno = "";
		if job == "insert"
		    return %Q{
		    	<div class='alert alert-success aviso-cadastro-alert' role='alert'>
		    		<span class='fa fa-check-circle-o' aria-hidden='true'></span> Cliente cadastrado com sucesso!
		    	</div>}.html_safe
		end
		if job == "update"
		    return %Q{
		    	<div class='alert alert-success aviso-cadastro-alert' role='alert'>
		    		<span class='fa fa-check-circle-o' aria-hidden='true'></span> Cliente atualizado com sucesso.
		    	</div>}.html_safe
		end
		if job == "delete"
		    return %Q{
		    	<div class='alert alert-warning aviso-cadastro-alert' role='alert'>
		    		<span class='fa fa-times-circle-o' aria-hidden='true'></span> Cliente deletado com sucesso.
		    	</div>}.html_safe
		end
	end
end
