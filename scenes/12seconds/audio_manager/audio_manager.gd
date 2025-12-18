class_name AudioManager extends Node2D

var current_background_music:AudioStream = null
var current_background_music_file:String = ""

signal change_music(music)

var background_music: AudioStreamPlayer = null
var sfx: AudioStreamPlayer 				= null
var splash: AudioStreamPlayer 			= null

func _init() -> void:
	change_music.connect(on_change_music)

func set_music_player(music_player:AudioStreamPlayer):
	background_music = music_player
	
func set_SFX_player(sfx_player:AudioStreamPlayer):
	sfx = sfx_player
	
func set_splash_player(splash_player:AudioStreamPlayer):
	splash = splash_player
	
	
func on_change_music(music):
	
	if music == "":
		background_music.stream_paused = true
		background_music.playing = false
		background_music.autoplay= false
		current_background_music_file = ""
		return
		
	if music == current_background_music_file:
		return
		
	current_background_music_file = music
	
	current_background_music = load(music)

	background_music.stream = current_background_music
	background_music.stream.loop = true
	background_music.playing = true
	background_music.autoplay = true


	
	
