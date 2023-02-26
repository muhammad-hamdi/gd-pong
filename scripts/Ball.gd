extends KinematicBody2D

export var speed = 300
export var max_speed = 500
var velocity = Vector2()

const DEFAULT_POSITION = Vector2(512, 300)
const DEFAULT_SPEED = 300

func _ready() -> void:
	randomize()
	velocity = Vector2.RIGHT.rotated(PI * randf())
	
func reset() -> void:
	position = DEFAULT_POSITION
	speed = DEFAULT_SPEED
	randomize()
	velocity = Vector2.RIGHT.rotated(PI * randf())

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if speed <= max_speed:
			speed += speed *0.05
			print(speed)
		var motion = collision.remainder.bounce(collision.normal)
		velocity = velocity.bounce(collision.normal)
		move_and_collide(motion)


func _on_P1Goal_body_entered(body: Node) -> void:
	reset()


func _on_P2Goal_body_entered(body: Node) -> void:
	reset()
