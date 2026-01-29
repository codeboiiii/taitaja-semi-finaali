extends Node

var save_file := "user://highscores.save"
var highscores := {}

func save_score(level_name: String, time: float):
	if not highscores.has(level_name) or time < highscores[level_name]:
		highscores[level_name] = time
		_write_file()

func load_scores():
	var file = File.new()
	if file.file_exists(save_file):
		file.open(save_file, File.READ)
		highscores = parse_json(file.get_as_text())
		file.close()

func _write_file():
	var file = File.new()
	file.open(save_file, File.WRITE)
	file.store_string(to_json(highscores))
	file.close()
