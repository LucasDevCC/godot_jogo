extends KinematicBody2D

var aceleracaoX = 450
var aceleracaoY = 50
var forca_pulo  = 1300
var velocidade  = Vector2.ZERO
var direcao     = -1
var animando    = false

func _ready():
	$Camera2D.limit_top  = 0
	$Camera2D.limit_left = 0
	$Camera2D.limit_bottom = get_viewport().size.y
	$Camera2D.limit_right = 2500
	
func _process(delta):
	velocidade.x = 0
	velocidade.y += aceleracaoY
	
	if (esta_vivo()):
		
		if (Input.is_action_pressed("ui_left")):
			velocidade.x = -aceleracaoX	
			direcao = -1
			$Sprite.flip_h = true
		
		elif (Input.is_action_pressed("ui_right")):
			velocidade.x = aceleracaoX	
			direcao = 1
			$Sprite.flip_h = false
		
		if (is_on_floor() and not animando):
			if (velocidade.x==0):
				$AnimationPlayer.play("respirando")
			else:
				$AnimationPlayer.play("andando")
			
		if (Input.is_action_just_pressed("ui_up") and is_on_floor()):
			velocidade.y = -forca_pulo
			$AnimationPlayer.play("pulando")
			
		if (is_on_floor() and not animando):
			if (Input.is_action_just_pressed("ui_accept") and DadosGlobais.qtd_balas>0):     
				$AnimationPlayer.play("atirando")
				atirar_balas()
				animando = true				
		
			if (Input.is_action_just_pressed("ui_down")):
				$AnimationPlayer.play("ataque")	
				animando = true	
				if (direcao==-1):
					$RayCast2DMaoEsq.enabled = true
				else:
					$RayCast2DMaoDir.enabled = true
				
	verificar_colisao_ataque()
		
	velocidade = move_and_slide(velocidade, Vector2.UP)
	
func verificar_colisao_ataque():
	var raycasts = [$RayCast2DMaoEsq, $RayCast2DMaoDir]

	for raycast in raycasts:
		if raycast.is_colliding():
			var collider = raycast.get_collider()
			
			# Proteção contra null ou tipos não esperados
			if collider == null:
				continue
			if not collider is Node:
				continue
			if not collider.has_method("get_node"):
				continue

			# Verifica se é um inimigo
			if collider.name == "Inimigo":
				if "esta_vivo" in collider:
					collider.esta_vivo = false
				if collider.has_node("AnimationPlayer"):
					collider.get_node("AnimationPlayer").play("morrendo")


			
	
func atirar_balas():
	DadosGlobais.qtd_balas -= 1
	var cena_municao = preload("res://cena_municao.tscn")	
	var objeto_balas = cena_municao.instance()	
	get_parent().add_child(objeto_balas)
	objeto_balas.global_position = $Position2D.global_position
	
	objeto_balas.get_node("KinematicBody2D").direcao = direcao


func animacao_finalizada(anim_name):
	if (anim_name=="morrendo"):
		get_tree().change_scene("res://cena_game_over.tscn")
	
	if (anim_name=="ataque"):
		$RayCast2DMaoEsq.enabled = false
		$RayCast2DMaoDir.enabled = false
	
	animando = false


func esta_vivo():
	if (DadosGlobais.qtd_vidas<=0):
		if (not animando and is_on_floor()):
			$AnimationPlayer.play("morrendo")
			animando = true
			aceleracaoX = 0
			forca_pulo  = 0
		return false
	else:
		return true
		

		
		
		
		
		
		
		
