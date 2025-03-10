extends CharacterBody2D

@export var start_speed = 1000.0
@export var incremental_speed = 1.002
@export var max_speed = 1300.0
@export var angle_range: Array[float] = [-250.0, 250.0]

@onready var score_sound = $"../Score/score_sound_se"

var started = false
var score = 0



func _physics_process(delta: float) -> void:
	if not started and Input.is_action_just_pressed("ui_select"):
		start_game()
	
	if started:
		var collision = move_and_collide(velocity * delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
			if collision.get_collider().name == "TopWall":
				score += 1
				score_sound.play()
				if velocity.length() <= max_speed:
					velocity *= incremental_speed

func start_game() -> void:
	started = true
	velocity = Vector2(angle_range.pick_random(), -start_speed)
