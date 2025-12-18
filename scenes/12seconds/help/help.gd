extends Control

func _on_previous_menu_pressed() -> void:
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
