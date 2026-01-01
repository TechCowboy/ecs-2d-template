extends Node2D

func _ready() -> void:
	Globals.am.play_music("")
	Globals.am.play_sfx(Globals.music_gamelost)

func _on_restart_button_pressed() -> void:
	Globals.sm.change_scene(Globals.game_start_scene)
