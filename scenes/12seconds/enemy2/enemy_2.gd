extends CharacterBody2D

@export var player : CharacterBody2D
@export var speed : float = 1
@onready var animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var death_timer: Timer = $DeathTimer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animated_sprite_2d.play("walk")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	var direction = player.position.x - position.x
	animated_sprite_2d.flip_h = direction > 0
	velocity.x += speed * direction

func _on_enemy_2_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		animated_sprite_2d.play("attack")
		death_timer.start()
		
func _on_death_timer_timeout() -> void:
	Globals.game_over_signal.emit()
