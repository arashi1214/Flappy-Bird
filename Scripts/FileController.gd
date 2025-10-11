extends Node

func save_file(file_name: String, save_data, path_prefix: String = "user://"):
	var file = FileAccess.open(path_prefix + file_name, FileAccess.WRITE)
	
	if not file:
		printerr("錯誤: 無法開啟檔案以寫入")
		return ERR_CANT_OPEN

	file.store_line(JSON.stringify(save_data))
	file.close()
	print("存檔成功到 user://" + file_name)

func load_file(file_name: String, path_prefix: String = "user://") -> Variant:
	var file_path = path_prefix + file_name

	# 檢查檔案是否存在
	if not FileAccess.file_exists(file_path):
		printerr("錯誤: 檔案不存在 - ", file_path)
		return null

	var file = FileAccess.open(file_path, FileAccess.READ)
	if not file:
		printerr("錯誤: 無法開啟檔案以讀取 - ", file_path)
		return null

	var file_content = file.get_as_text()
	file.close()

	var json_parser = JSON.new()
	var parse_result = json_parser.parse(file_content)

	if parse_result != OK:
		printerr("錯誤: JSON 解析失敗 - ", json_parser.get_error_message(), " (於 ", file_path, ")")
		return null
		
	return json_parser.data


func reset_file():
	var save_data = {
		"Score": 0
	}
	
	save_file("game_save.dat", save_data)
