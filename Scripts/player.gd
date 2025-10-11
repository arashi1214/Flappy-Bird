extends RigidBody2D

@export var speed = 300
@export var GameController: Node2D

@export var jump_audio: AudioStreamOggVorbis
@export var die_audio: AudioStreamOggVorbis

var status = false

func _physics_process(_delta):
	if Input.is_action_just_pressed("Jump") and status:
		apply_central_impulse(Vector2(0, -speed))
		$AudioStreamPlayer.stream = jump_audio
		$AudioStreamPlayer.play()


func _on_body_entered(body: Node) -> void:
	if "障礙物" in body.get_groups():
		GameController.GameOver()
		$AudioStreamPlayer.stream = die_audio
		$AudioStreamPlayer.play()
