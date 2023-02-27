extends KinematicBody2D

const DEFAULT_SPEED = 400
export var speed = 400

var direction : float = 0
var toss: bool = false
var velocity := Vector2()

export(String, "right", "left") var side = "right"
export(String, "player", "ai") var control = "player"

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	if control == "player":
		match side:
			"right":
				direction = Input.get_action_strength("down_right") - Input.get_action_strength("up_right")
				toss = Input.is_action_just_pressed("right_toss")
			"left":
				direction = Input.get_action_strength("down_left") - Input.get_action_strength("up_left")
				toss = Input.is_action_just_pressed("left_toss")

func _physics_process(delta: float) -> void:
	velocity.y = direction * speed
	if toss:
		$AnimationPlayer.play("shake")
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var body = collision.collider as PhysicsBody2D
		if body != null && body.is_in_group("ball"):
			if $AnimationPlayer.current_animation == "shake":
				speed = DEFAULT_SPEED * 1.5
				yield(get_tree().create_timer(5.0), "timeout")
				speed = DEFAULT_SPEED
