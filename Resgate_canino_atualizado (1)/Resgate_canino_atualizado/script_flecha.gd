extends KinematicBody2D

var aceleracaoX = 550
var direcao = -1
var velocidade  = Vector2.ZERO

func _ready():
	pass

func _process(delta):
	velocidade.x = direcao * aceleracaoX
	if (direcao==1):
		$Sprite.flip_h = true
	
	verificar_colisao()
	
	move_and_slide(velocidade)
	
func verificar_colisao():
	if ($RayCast2D.is_colliding()):
		if ($RayCast2D.get_collider().name=="Inimigo"):
			$RayCast2D.get_collider().esta_vivo = false
			$RayCast2D.get_collider().get_node("AnimationPlayer").play("morrendo")
			get_parent().queue_free()
			
			
		
		
		
		
		
		
	
