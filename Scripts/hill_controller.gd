extends Node2D

@export var create_area_Y : float

var hill_object

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hill_object = preload("res://Objects/hill.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# 生成障礙物
func create_hill():
	var instance = hill_object.instantiate()
	var top_instance = hill_object.instantiate()

	# 生成隨機高度障礙物
	instance.position = $Marker2D_bottom.position
	instance.position.y += randf_range(-1, create_area_Y) * 10
	
	top_instance.rotation_degrees = 180
	top_instance.position = $Marker2D_top.position
	top_instance.position.y -= randf_range(-1, create_area_Y) * 10
	
	add_child(instance)
	add_child(top_instance)
	
