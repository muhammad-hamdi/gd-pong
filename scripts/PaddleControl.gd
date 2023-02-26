extends KinematicBody2D

export var speed = 400

var direction : float = 0
var velocity := Vector2()

export(String, "right", "left") var side = "right"

func _input(event: InputEvent) -> void:
	match side:
		"right":
			direction = Input.get_action_strength("down_right") - Input.get_action_strength("up_right")
		"left":
			direction = Input.get_action_strength("down_left") - Input.get_action_strength("up_left")

func _physics_process(delta: float) -> void:
	velocity.y = direction * speed
	
	move_and_slide(velocity)
	
#	for i in get_slide_count():
#		var col = get_slide_collision(i)
#		print(col.collider.name)
		
