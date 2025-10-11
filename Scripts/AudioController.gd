extends Node

# 背景音樂
func play_audio(audio_name, pre_path = "res://Audio/"):
	$AudioStreamPlayer.stream = load(pre_path + audio_name)
	$AudioStreamPlayer.play()

func stop_audio():
	$AudioStreamPlayer.stop()


func _on_h_scroll_bar_value_changed(value: float) -> void:
	$AudioStreamPlayer.volume_db = value
