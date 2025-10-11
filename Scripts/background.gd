extends Node2D

var status = false

func _process(_delta: float) -> void:
	if status:
		position.x -= 1
		
		if position.x <= -1235:
			position.x = 1280
