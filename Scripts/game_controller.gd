extends Node

var status = "Start"

func _ready() -> void:
	var font = load("res://Font/NotoSansCJKtc-hinted/NotoSansCJKtc-Bold.otf")
	get_tree().root.add_theme_font_override("default_font", font)
	
	var rank = $FileController.load_file("game_save.dat")
	
	if rank == null:
		$FileController.reset_file()
	else:
		$Menu/HighScore.text = "最高分數：" + str(int(rank["Score"]))


func GameStart():
	if status == "Start":
		$Menu.visible = false
		$Setting.visible = false
		$"Hill controller/Timer".start()
		$"Hill controller".create_hill()
		$GameTimer.start()
		$AudioController.play_audio("maou_game_village10.ogg")
		status = "Reset"
		
		var all_obstacle = get_tree().get_nodes_in_group("playing_object")
		
		for obstacle in all_obstacle:
			obstacle.status = true
	else:
		var current_scene_path = get_tree().current_scene.scene_file_path
		get_tree().change_scene_to_file(current_scene_path)
	
func GameOver():
	# 顯示重置按鈕
	$Menu.visible = true
	
	# 停止遊戲運作
	$"Hill controller/Timer".stop()
	$GameTimer.stop()
	$AudioController.stop_audio()
	
	var all_run_object = get_tree().get_nodes_in_group("playing_object")
	
	for obstacle in all_run_object:
		obstacle.status = false

	# 更新最高分數
	update_ranking(int($Score.text))
	$Menu/NowScore.text = "當前分數：" + $Score.text
	
	status = "GameOver"

func GamePause():
	if status == "Reset":
		# 顯示設定選單
		$Setting.visible = true
		
		# 停止遊戲運作
		$"Hill controller/Timer".stop()
		$GameTimer.stop()
		$AudioController/AudioStreamPlayer.stream_paused = true
		
		var all_run_object = get_tree().get_nodes_in_group("playing_object")
		
		for obstacle in all_run_object:
			obstacle.status = false
			
		status = "Pause"
	elif status == "Pause":
		# 關閉設定選單
		$Setting.visible = false
		
		# 開始遊戲運作
		$"Hill controller/Timer".start()
		$GameTimer.start()
		$AudioController/AudioStreamPlayer.stream_paused = false
		
		var all_run_object = get_tree().get_nodes_in_group("playing_object")
		
		for obstacle in all_run_object:
			obstacle.status = true
			
		status = "Reset"
		
	elif status == "Start" or "GameOver":
		$Setting.visible = !$Setting.visible

func update_score():
	var score = int($Score.text)
	score += 1
	$Score.text = str(score)
	
	
func update_ranking(score):
	var rank = $FileController.load_file("game_save.dat")
	
	if score > rank["Score"]  :
		rank["Score"] = score
		$FileController.save_file("game_save.dat",rank)
		$Menu/HighScore.text = "最高分數：" + str(score)
		print("更新最高分")
	else:
		print("沒有變化")
