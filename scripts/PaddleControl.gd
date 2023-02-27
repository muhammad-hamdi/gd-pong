extends KinematicBody2D

export var DEFAULT_SPEED = 400
export var speed = 400

var direction : float = 0
var toss: bool = false
var velocity := Vector2()
var initial_x: float
var powered: bool = false

export(String, "right", "left") var side = "right"
export(String, "player", "ai") var control = "player"

func _ready() -> void:
	initial_x = position.x

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
	position.x = initial_x
	velocity.y = direction * speed
	if toss:
		$AnimationPlayer.play("shake")
	
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		var body = collision.collider as PhysicsBody2D
		if body != null && body.is_in_group("ball"):
			if $AnimationPlayer.current_animation == "shake":
				if !powered:
					speed = DEFAULT_SPEED * 1.5
					$SpritePowered.show()
					powered = true
			else:
				speed = DEFAULT_SPEED
				$SpritePowered.hide()
				powered = false
#				$Sprite.material.set_shader_param("interpolation", 0.5)
#				$Sprite.material.set_shader_param("interpolation", 0)


func _on_BallDetector_body_entered(body: Node) -> void:
	print(body.name)
