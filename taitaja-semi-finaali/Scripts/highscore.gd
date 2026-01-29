extends Node

var save_file := "user://highscores.save"
var highscores := {}

func save_score(level_name: String, time: float):
	if not highscores.has(level_name) or time < highscores[level_name]:
		highscores[level_name] = time
		_write_file()

func load_scores():
	if FileAccess.file_exists(save_file):
		var file = FileAccess.open(save_file, FileAccess.READ)
		if file:
			var text = file.get_as_text()
			var result = JSON.parse_string(text)
			if result.error == OK:
				highscores = result.result
			file.close()

func _write_file():
	var file = FileAccess.open(save_file, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(highscores))
		file.close()
