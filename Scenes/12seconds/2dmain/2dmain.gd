extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.game_over_signal.connect(on_game_over)
	Globals.items_collected_signal.connect(on_item_collected)
	

func on_game_over() -> void:
	print("Game Over!")
	get_tree().change_scene_to_file("uid://h6x55wwner7e")

func on_item_collected(value):
	Globals.items_collected += value
	print("Items Collected: " + str(Globals.items_collected))
	Globals.score_signal.emit("Score: "+ str(Globals.items_collected))
	
	
