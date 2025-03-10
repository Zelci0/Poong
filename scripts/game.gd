extends Node2D

@onready var ball = $Ball
@onready var label_score = $Score
@onready var label_tutorial = $Tutorial
@onready var positions = $Positions
@onready var explosion_sound = $asteroid_explosion
@onready var background = $Background


var asteroid_scene = preload("res://scenes/asteroide.tscn")
var last_position = null

var resource_asteroids = {}
var resources_background = {}
var resources_colors_label = {}

var new_asteroid_color


func _process(_delta: float) -> void:
	
	if ball.started:
		label_score.visible = ball.started
		label_tutorial.visible = not ball.started
		label_score.text = str(ball.score)
		check_score(ball.score)

func _ready() -> void:
	preload_resources()

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
		if new_asteroid_color != null:
			asteroid.get_node("Sprite2D").texture = new_asteroid_color
		add_child(asteroid)
		last_position = spawn_position
	else:
		spawn_asteroid()

func preload_resources():
	resource_asteroids = {
		"asteroid1": preload("res://sprites/Asteroide1.png"),
		"asteroid2": preload("res://sprites/Asteroide2.png"),
		"asteroid3": preload("res://sprites/Asteroide3.png"),
		"asteroid4": preload("res://sprites/Asteroide4.png"),
		"asteroid5": preload("res://sprites/Asteroide5.png"),
		"asteroid6": preload("res://sprites/Asteroide6.png")
	}
	
	resources_background = {
		"background1": preload("res://sprites/Fundo1.png"),
		"background2": preload("res://sprites/Fundo2.png"),
		"background3": preload("res://sprites/Fundo3.png"),
		"background4": preload("res://sprites/Fundo4.png"),
		"background5": preload("res://sprites/Fundo5.png"),
		"background6": preload("res://sprites/Fundo6.png")
	}
	
	resources_colors_label = {
		"color1": "7601f6",
		"color2": "4196ff",
		"color3": "4ea771",
		"color4": "fe9c35",
		"color5": "ff5d5d",
		"color6": "762d79"
	}

func check_score(score):
	match score:
		0:
			update_colors("color1", "background1")
		10:
			update_colors("color2", "background2")
			update_asteroids("asteroid2")
		20:
			update_colors("color3", "background3")
			update_asteroids("asteroid3")
		30:
			update_colors("color4", "background4")
			update_asteroids("asteroid4")
		40:
			update_colors("color5", "background5")
			update_asteroids("asteroid5")
		50:
			update_colors("color6", "background6")
			update_asteroids("asteroid6")

func update_colors(key_color_label, key_color_bg):
	label_score.label_settings.font_color = resources_colors_label[key_color_label]
	background.set_texture(resources_background[key_color_bg])
	pass

func update_asteroids(key_asteroid):
	var asteroids = get_tree().get_nodes_in_group("asteroids")
	
	for asteroid in asteroids:
		asteroid.get_node("Sprite2D").texture = resource_asteroids[key_asteroid]
	
	new_asteroid_color = resource_asteroids[key_asteroid]
