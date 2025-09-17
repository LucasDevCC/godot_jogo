extends Node2D

func _ready():
	DadosGlobais.inicializar_dados()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):	
	$LabelFlecha.text  = "X " + str(DadosGlobais.qtd_balas)
	$LabelCoracao.text = "X " + str(DadosGlobais.qtd_vidas)
	
	
