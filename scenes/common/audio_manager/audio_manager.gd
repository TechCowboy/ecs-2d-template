## The AudioManager class provides an easy mechanism
## to manage sounds for Music, Sound Effects and the Splash Screen
## There is a master volume for all of these channels and
## individual volumes for each channel as well.
## [br][br]
## Click on AudioManager above to see all documentation
## [br][br]
## Usage Example
## [br]
## [code]
## var am = AudioManager.new()	# in your globals file
## [/code]
## [br]
## [code]
## Globals.am.set_music_player(%Music)	# Set AudioStreamPlayers 
## Globals.am.set_SFX_player(%Sfx)	# in your game
## Globals.am.set_splash_player(%Splash)	# initialization section
## [/code]
## [br]
## [code]
## Globals.am.play_music("uid://bpjore1mmj76b") # play some music
## [/code]

class_name AudioManager extends Node2D

var _current_background_music:AudioStream = null
var _current_background_music_file:String = ""
var _current_sfx:AudioStream              = null

## Contains the integer index for the Master bus.
## Use this for accessing the bus index dynamically, 
## ensuring the correct index is used even if the bus structure changes
var master_bus_index:int

## Contains the integer index for the Music bus.
## Use this for accessing the bus index dynamically, 
## ensuring the correct index is used even if the bus structure changes
var music_bus_index:int	

## Contains the integer index for the Sound effects bus.
## Use this for accessing the bus index dynamically, 
## ensuring the correct index is used even if the bus structure changes
var sfx_bus_index:int	

## Contains the integer index for the Splash bus.
## Use this for accessing the bus index dynamically, 
## ensuring the correct index is used even if the bus structure changes
var splash_bus_index:int

const SOUND_KEY_MASTER:String	= "Master" 	## Master channel name 
const SOUND_KEY_MUSIC: String	= "Music"	## Music channel name
const SOUND_KEY_SFX:   String	= "SFX"		## Sound Effects channel name
const SOUND_KEY_SPLASH:String	= "Splash"	## Splash screen channel name

## string of resource to music to play, recommend using an UID, music will loop when finished
signal _play_music(music:String)

## string of resource to sound effect to play, recommend using an UID, sfx will not loop when finished
signal _play_sfx(sound:String)

## string of resource to splash sound to play, recommend using an UID, sound will not loop when finished
signal _play_splash(sound:String)

## 'signals' the end of playing a sound effect
signal _sfx_finished()

var _music:  AudioStreamPlayer 	= null
var _sfx:    AudioStreamPlayer 	= null
var _splash: AudioStreamPlayer 	= null

func _init() -> void:

	master_bus_index 	= AudioServer.get_bus_index("Master")
	music_bus_index 	= AudioServer.get_bus_index("Music")
	sfx_bus_index 		= AudioServer.get_bus_index("SFX")
	splash_bus_index 	= AudioServer.get_bus_index("Splash")
	
	_play_music.connect(_on_change_music)
	_play_sfx.connect(_on_sfx)
	_play_splash.connect(_on_change_splash)
		
## Sets the AudioSteamPlayer to use for playing music	
func set_music_player(music_player:AudioStreamPlayer):
	_music = music_player
	_music.bus = SOUND_KEY_MUSIC
	
## Sets the AudioSteamPlayer to use for playing sound effects	
func set_SFX_player(sfx_player:AudioStreamPlayer):
	_sfx = sfx_player
	_sfx.bus = SOUND_KEY_SFX
	_sfx.finished.connect(_on_sfx_finished)

	
## Sets the AudioSteamPlayer to use for playing sounds during the splash screen	
func set_splash_player(splash_player:AudioStreamPlayer):
	_splash = splash_player
	_splash.bus = SOUND_KEY_SPLASH
	
## Sets the volume used on all bus channels	
## the range of value must be between 0 and 1
func set_master_volume(value:float):
	AudioServer.set_bus_volume_linear(master_bus_index, value)
	
## Sets the volume used on the music bus channel
## the range of value must be between 0 and 1
func set_music_volume(value:float):
	AudioServer.set_bus_volume_linear(music_bus_index, value)
	
## Sets the volume used on the sound effect bus channel
## the range of value must be between 0 and 1
func set_SFX_volume(value:float):
	AudioServer.set_bus_volume_linear(sfx_bus_index, value)
	
## Sets the volume used on the splash bus channel
## the range of value must be between 0 and 1
func set_splash_volume(value:float):
	AudioServer.set_bus_volume_linear(splash_bus_index, value)

		
func _on_change_music(new_music:String):
	
	if _music == null:
		print("_music AudioStreamPlayer is null!")
		return
		
	if new_music == "":
		_music.stream_paused = true
		_music.playing = false
		_music.autoplay= false
		_current_background_music_file = ""
		return
		
	if new_music == _current_background_music_file:
		return
		
	_current_background_music_file = new_music
	
	_current_background_music = load(new_music)
	
	if _current_background_music == null:
		print("current_background_music failed to load")
		return
		
	_music.stream = _current_background_music
	_music.stream.loop = true
	_music.playing = true
	_music.autoplay = true


func _on_change_splash(new_music:String):
	var current_splash
	
	if _splash == null:
		print("_splash AudioStreamPlayer is null!")
		return
		
	if new_music == "":
		_music.stream_paused = true
		_music.playing = false
		_music.autoplay= false
		return
		
		
	
	current_splash = load(new_music)
	
	if current_splash == null:
		print("current_splash failed to load")
		return
		
	_splash.stream = current_splash
	_splash.stream.loop = false
	_splash.playing = true
	_splash.autoplay = true


func _on_sfx(new_sfx:String):

	if _sfx == null:
		print("_sfx AudioStreamPlayer is null!")
		return
		
	if new_sfx == "":
		_sfx.stream_paused = true
		_sfx.playing = false
		_sfx.autoplay= false
		return
				
	_current_sfx = load(new_sfx)
	if _current_sfx == null:
		print("current_sfx failed to load" + new_sfx)
		return
	
	_sfx.stream = _current_sfx
	_sfx.stream.loop = false
	_sfx.playing = true
	_sfx.autoplay = true
	
func _on_sfx_finished():
	_sfx_finished.emit()

func play_music(new_music):
	_play_music.emit(new_music)
	
func play_sfx(new_sfx):
	_play_sfx.emit(new_sfx)
	
func play_splash(new_splash):
	_play_splash.emit(new_splash)
	
