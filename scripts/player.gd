extends CharacterBody2D

@export var velocidade = 500.0
@onready var ball = $"../Ball"

func _physics_process(delta: float) -> void:
	if not ball.started:
		return
	
	velocity.x = Input.get_axis("ui_left", "ui_right") * velocidade
	move_and_collide(velocity * delta)
