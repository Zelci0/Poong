extends CharacterBody2D

@onready var score_sound = get_parent().get_node("Score/score_sound")

# Indica se a bola está em movimento (booleano: verdadeiro ou falso)
var started = false

# Velocidade inicial da bola (em pixels por segundo)
var start_speed = 500

# Aumenta a velocidade da bola sempre que colidir com a parede do canva
var incremental_speed = 1.002

# Define a velocidade horizontal no momento do arremesso
var angle = [-250, 250]

# Define a pontuação inicial do jogo
var score = 0


# Atualiza o movimento da bola a cada quadro
# Inicia o movimento ao pressionar a barra de espaço ("ui_select" definida no projeto)
func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_select") and started == false:
		start_game()


	if started:
		var collision = move_and_collide(velocity * delta)

		if collision != null:
			if collision.get_collider().name == "TopWall":
				score += 1
				score_sound.play()
				velocity = velocity.bounce(collision.get_normal()) * incremental_speed
			else:
				velocity = velocity.bounce(collision.get_normal())


# Inicia o movimento da bola: define 'started' como verdadeiro
# e a impulsiona para cima no eixo Y com a velocidade definida
func start_game():
	started = true
	velocity.y = -start_speed
	velocity.x = angle.pick_random()
