extends Node2D

@onready var gameover_ui = $GameoverUI
@onready var victory_ui = $VictoryUI
@onready var hazard = $ChasingHazard
@onready var player = $Pelaaja

var run_active := false
var run_time := 0.0

func _process(delta):
	if run_active:
		run_time += delta

func start_run():
	run_active = true
	run_time = 0.0

func end_run_gameover():
	if not run_active:
		return
	
	run_active = false
	Engine.time_scale = 0.2
	
	await get_tree().create_timer(1.2).timeout
	Engine.time_scale = 1.0
	
	gameover_ui.show()
	gameover_ui.set_time(run_time)


func end_run_victory():
	if not run_active:
		return
	
	run_active = false
	victory_ui.show()
	victory_ui.set_time(run_time)
	save_best_time(run_time)
	
const SAVE_PATH := "user://best_time.save"

func save_best_time(time: float):
	var best = load_best_time()
	if best == 0 or time < best:
		var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
		file.store_float(time)

func load_best_time() -> float:
	if not FileAccess.file_exists(SAVE_PATH):
		return 0.0
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	return file.get_float()
