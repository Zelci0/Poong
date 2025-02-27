extends Area2D

@export var speed = 140.0
@export var rotation_speed = 1.3
@onready var timer_delete = $TimerDelete

var direction = 1

func _ready() -> void:
	direction = -1 if global_position.x > 540 else 1

func _process(delta: float) -> void:
	global_position.x += speed * direction * delta
	rotation += rotation_speed * direction * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	timer_delete.start()

func _on_timer_delete_timeout() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if not "Asteroide" in body:
		body.score += 1
		get_parent().play_explosion_sound()  # Chama a função no nó pai
		queue_free()
