class_name Coin extends AnimatedSprite2D

func _on_coin_area_2d_body_entered(body: Node2D) -> void:
	
	if body.is_in_group("player"):
		Globals.items_collected_signal.emit(1)
		Globals.am.play_sfx(Globals.sfx_item_collected)
		queue_free()
		
		
		
