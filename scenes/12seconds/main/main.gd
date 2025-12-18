extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	Globals.am.set_music_player(%MusicPlayer)
	Globals.am.set_SFX_player(%SFXPlayer)
	Globals.am.set_splash_player(%SplashPlayer)

	Globals.sm.set_scene_folder(%CurrentScene)
	Globals.sm.change_scene.emit(Globals.game_main_menu_scene)
