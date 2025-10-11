extends Area2D


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D):
	if "障礙物" in body.get_groups():
		print("消失")
		body.queue_free()
