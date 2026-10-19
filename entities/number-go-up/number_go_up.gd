extends Node2D

var presses_since_last_frame: int = 0
var game_state: GameState = GameState.new()

var lifetime: float = 0

func _physics_process(delta: float) -> void:
	lifetime += delta
	
	presses_since_last_frame = 0
	if (Input.is_action_just_pressed("Space")):
		presses_since_last_frame = 1
	
	var window: Window = get_window()
	game_state.step(presses_since_last_frame, window)
	$Score.text = str(game_state.score)
