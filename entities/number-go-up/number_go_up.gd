extends Node2D

var game_state: GameState = GameState.new()

func _ready() -> void:
	pass

var lifetime: float = 0

func _physics_process(delta: float) -> void:
	lifetime += delta
	
	if (Input.is_action_just_pressed("Space")):
		game_state.score += 1
	if (game_state.score >= 1):
		$Message.text = "Woah, you're\nreally popping off"
	$Score.text = str(game_state.score)
	
	var window = get_window()
	var alpha = lifetime * 0.1
	if (alpha >= 1.):
		window.content_scale_size = Vector2i(1920,1080)
	else:
		var x: float = ((1-alpha) * 640.) + (alpha * 1920.)
		var y: float = ((1-alpha) * 268.) + (alpha * 1080.)
		get_window().content_scale_size = Vector2i(type_convert(x,TYPE_INT),type_convert(y,TYPE_INT))
	
