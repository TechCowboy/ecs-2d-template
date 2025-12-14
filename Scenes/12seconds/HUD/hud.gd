extends Control
@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@onready var score: RichTextLabel = %Score

@export var max_progress_bar = 12.0
@export var seconds_max = 12.0
var step = max_progress_bar / seconds_max


func _ready() -> void:
	score.text 				= "Score: 0"
	Globals.score_signal.connect(on_score_updated)
	
	progress_bar.max_value 	= max_progress_bar
	progress_bar.min_value 	= 0
	progress_bar.value     	= max_progress_bar
	timer.one_shot  		= false
	timer.autostart 		= true
	timer.wait_time 		= 1.0
	timer.start()
	
func _on_timer_timeout() -> void:
	progress_bar.value -= step
	
	if progress_bar.value <= 0.0:
		Globals.game_over_signal.emit()
		

func on_score_updated(score_text):
	score.text = score_text
	

	
