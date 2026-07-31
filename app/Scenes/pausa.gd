extends CanvasLayer

func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	hide()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and not Global.juego_terminado:
		get_tree().paused = not get_tree().paused
		visible = get_tree().paused
		get_viewport().set_input_as_handled()
