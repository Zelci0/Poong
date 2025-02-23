extends Node2D

@onready var ball = $Ball
@onready var label_score = $Score
@onready var label_tutorial = $Tutorial
@onready var positions = $Positions
var last_position
var asteroid_scene = preload("res://scenes/asteroide.tscn")

func _process(_delta: float) -> void:
	
	if ball.started:
		label_score.visible = true
		label_tutorial.visible = false
	
	label_score.text = str(ball.score)


func _on_dead_zone_body_entered(_body: Node2D) -> void:
	call_deferred("reload_scene")

func reload_scene():
	get_tree().reload_current_scene()


func _on_timer_spawner_timeout() -> void:
	#Gera os asteróides quando o timer chega a 0
	spawn_asteroid()
	
	
func spawn_asteroid():
	#Gera os asteróides
	if (ball.started):
		var positions_list = positions.get_children()
		var spawn_position = positions_list.pick_random()
		
		if (spawn_position != last_position):
			var asteroide_instance = asteroid_scene.instantiate()
			asteroide_instance.global_position = spawn_position.position
			add_child(asteroide_instance)
			last_position = spawn_position
		else:
			spawn_asteroid()
