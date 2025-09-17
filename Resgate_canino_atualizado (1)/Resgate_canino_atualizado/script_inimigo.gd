extends KinematicBody2D

var aceleracaoX = 200
var aceleracaoY = 20
var velocidade  = Vector2.ZERO
var direcao     = -1 # 1 é direita, -1 é esquerda
var comportamento = 4
var esta_vivo = true

func _ready():
	get_tree().root.print_tree()
	pass

func _process(delta):
	velocidade.x = 0
	velocidade.y += aceleracaoY
	
	if (esta_vivo):
		if (comportamento==1):
			comportamento1()
		elif (comportamento==2):
			comportamento2()
		elif (comportamento==3):
			comportamento3()
		elif (comportamento==4):
			comportamento4()
			
		if (is_on_floor()):
			if(direcao==-1):
				velocidade.x = -aceleracaoX		
				$Sprite.flip_h = true		
			if(direcao==1):
				velocidade.x = aceleracaoX				
				$Sprite.flip_h = false
		
	velocidade = move_and_slide(velocidade,Vector2.UP)


func comportamento1():
	if (global_position.x<0):
		direcao = 1
	elif (global_position.x>get_viewport().size.x):
		direcao = -1
	
func comportamento2():
	var nfase = DadosGlobais.num_fase
	var personagem = get_tree().root.get_node("Fase" + str(nfase) + "/Personagem/Personagem")
	if (personagem.global_position.x < global_position.x):
		direcao = -1
		
	else:
		direcao = 1
	
		
func comportamento3():
	$AnimationPlayer.play("andando")

	if ($RayCast2DMaoEsq.is_colliding()):
		if ($RayCast2DMaoEsq.get_collider().name=="Personagem"):
			direcao = -1
	
	if ($RayCast2DMaoDir.is_colliding()):
		if ($RayCast2DMaoDir.get_collider().name=="Personagem"):
			direcao = 1
	
	if (not $RayCast2DPeEsq.is_colliding()):
		direcao = 1
		
	if (not $RayCast2DPeDir.is_colliding()):
		direcao = -1

func comportamento4():
	
	aceleracaoX = 0
	if (not $RayCast2DMaoEsq.is_colliding() and not $RayCast2DMaoDir.is_colliding()):
		$AnimationPlayer.play("parado")
	
	elif ($RayCast2DMaoEsq.is_colliding()):
		if ($RayCast2DMaoEsq.get_collider().name=="Personagem"):
			$AnimationPlayer.play("atacando")
			$Sprite.flip_h = false
	elif ($RayCast2DMaoDir.is_colliding()):
		if ($RayCast2DMaoDir.get_collider().name=="Personagem"):
			$AnimationPlayer.play("atacando")
			$Sprite.flip_h = true	

func causar_dano(anim_name):
	if (anim_name=="atacando"):
		if ($RayCast2DMaoEsq.is_colliding()):
			if ($RayCast2DMaoEsq.get_collider().name=="Personagem"):
				if (DadosGlobais.qtd_vidas>0):
					DadosGlobais.qtd_vidas -= 1
	
func destruir():
	get_parent().queue_free()
	
	
	
