extends Node2D

var p1_score = 0
var p2_score = 0

func _on_P1Goal_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		p2_score += 1
		score_procedure("P2", p2_score)

func _on_P2Goal_body_entered(body: Node) -> void:
	if body.is_in_group("ball"):
		p1_score += 1
		score_procedure("P1", p1_score)

func score_procedure(player: String, score: int) -> void:
	get_tree().paused = true
	$Ball.reset()
	EventBus.emit_signal("goal_scored", player, score)
	yield(get_tree().create_timer(1.0),"timeout")
	get_tree().paused = false
