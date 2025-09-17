extends Area2D

func _ready():
	pass # Replace with function body.


func _process(delta):
	pass



func coletar_flecha(body):
		if (body.name=="Personagem"):
			DadosGlobais.qtd_balas += 1
			get_parent().queue_free()
	
