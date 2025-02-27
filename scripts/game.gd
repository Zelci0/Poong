extends Node2D

@onready var ball = $Ball
@onready var label_score = $Score
@onready var label_tutorial = $Tutorial
@onready var positions = $Positions
@onready var explosion_sound = $asteroid_explosion  # Filho direto do root

var asteroid_scene = preload("res://scenes/asteroide.tscn")
var last_position = null

func _process(_delta: float) -> void:
	label_score.visible = ball.started
	label_tutorial.visible = not ball.started
	label_score.text = str(ball.score)

func _on_dead_zone_body_entered(_body: Node2D) -> void:
	get_tree().reload_current_scene()

func _on_timer_spawner_timeout() -> void:
	if ball.started:
		spawn_asteroid()

func play_explosion_sound() -> void:
	if explosion_sound and not explosion_sound.playing:
		explosion_sound.play()

func spawn_asteroid() -> void:
	var spawn_points = positions.get_children()
	var spawn_position = spawn_points.pick_random()
	
	if spawn_position != last_position:
		var asteroid = asteroid_scene.instantiate()
		asteroid.global_position = spawn_position.position
		add_child(asteroid)
		last_position = spawn_position
	else:
		spawn_asteroid()
