extends Area2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	pass


func ganhar_vidas(body):
	if (body.name == "Personagem"):
		DadosGlobais.qtd_vidas += 1
		get_parent().queue_free()
		
		
