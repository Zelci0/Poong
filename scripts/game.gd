extends Node2D

@onready var ball = $Ball
@onready var label_score = $Score
@onready var label_tutorial = $Tutorial

func _process(delta: float) -> void:
	
	if ball.started:
		label_score.visible = true
		label_tutorial.visible = false
	
	label_score.text = str(ball.score)


func _on_dead_zone_body_entered(body: Node2D) -> void:
	get_tree().reload_current_scene()
