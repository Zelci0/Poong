extends CharacterBody2D

# Torna a variável 'velocidade' visível e editável no inspector do nó Player
@export var velocidade = 500

# Armazena a referência do nó "Ball" obtida ao iniciar o jogo
var ball

# Obtém a referência da bola ("Ball") dentro do nó pai ("Game") ao iniciar
func _ready() -> void:
	ball = get_parent().get_node("Ball")

# Atualiza o movimento do personagem a cada quadro
# Define a velocidade horizontal como zero inicialmente
func _physics_process(delta: float) -> void:

	velocity.x = 0

# Move para a esquerda ao pressionar a seta esquerda, se a bola já estiver em movimento
	if Input.is_action_pressed("ui_left") and ball.started == true:
		velocity.x -= velocidade

# Move para a direita ao pressionar a seta direita, se a bola já estiver em movimento
	if Input.is_action_pressed("ui_right") and ball.started == true:
		velocity.x += velocidade

# Move o personagem considerando colisões
# Usa delta para garantir movimento consistente em qualquer taxa de quadros (FPS)
	move_and_collide(velocity * delta)
