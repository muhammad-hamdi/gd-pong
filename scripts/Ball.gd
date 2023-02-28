extends KinematicBody2D

export var speed = 300
export var max_speed = 500
var velocity = Vector2()

const DEFAULT_POSITION = Vector2(512, 300)
const DEFAULT_SPEED = 300

func _ready() -> void:
	randomize()
#	velocity = Vector2.RIGHT * choose([-1, 1])
	velocity = Vector2.RIGHT.rotated(rand_range(-0.25, 0.25) * PI)
	
func reset() -> void:
	$Particles2D.restart()
	position = DEFAULT_POSITION
	speed = DEFAULT_SPEED
	randomize()
#	velocity = Vector2.RIGHT * choose([-1, 1])
	velocity = Vector2.RIGHT.rotated(rand_range(-0.25, 0.25) * PI)

func _physics_process(delta: float) -> void:
	var collision = move_and_collide(velocity * speed * delta)
	if collision:
		if speed <= max_speed:
			speed += speed *0.05
		var reaction_vec: Vector2 = collision.normal
		if collision.collider is KinematicBody2D:
			reaction_vec = reaction_vec.rotated(clamp(collision.collider.velocity.y, 0, 1) * PI)
		var motion = collision.remainder.bounce(reaction_vec)
		velocity = velocity.bounce(reaction_vec)
		move_and_collide(motion)

func choose(array):
	return array[randi() % array.size()]
