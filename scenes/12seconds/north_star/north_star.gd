extends Sprite2D

@onready var north_star: Sprite2D = $"."

func _ready() -> void:
	Globals.move_star_up.connect(on_move_star_up)
	
func on_move_star_up(amount):
	print("Move star up")
	north_star.position.y += amount
	
	
