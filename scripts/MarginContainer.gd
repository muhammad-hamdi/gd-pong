extends MarginContainer

onready var P1Label = $HBoxContainer/P1
onready var P2Label = $HBoxContainer/P2

func _ready() -> void:
	EventBus.connect("goal_scored", self, "set_score_value")

func set_score_value(player: String, score: int) -> void:
	if player == "P1":
		P1Label.text = str(score)
	else:
		P2Label.text = str(score)
