extends Resource
class_name GameState
enum State {
	BEGIN,
	GROW_WINDOW,
	GROW_WINDOW_2,
}

var score: int = 0
var state: State
var decay_numerator_score: int = 0
var decay_denominator_frames: int = 1

var screen_size_1: Vector2 = Vector2(288,240)
var screen_size_2: Vector2 = Vector2(756,540)
var screen_size_3: Vector2 = Vector2(1920,1080)

var state_lifetime_frames = 0
var lifetime_frames: int = 0
var next_state: State
func step(presses_since_last_frame: int, window: Window) -> void:
	lifetime_frames += 1
	state_lifetime_frames += 1
	if (lifetime_frames % decay_denominator_frames == 0):
		score -= decay_numerator_score
	
	if state != next_state:
		state = next_state
		state_lifetime_frames = 0
	score += presses_since_last_frame
	match state:
		State.BEGIN:
			window.content_scale_size = Vector2i(screen_size_1)
			if score >= 1:
				next_state = State.GROW_WINDOW
		State.GROW_WINDOW:
			var alpha = type_convert(state_lifetime_frames, TYPE_FLOAT) * (1./120.) * 0.1
			alpha = min(alpha,1.)
			if (alpha >= 1.):
				window.content_scale_size = Vector2i(screen_size_2)
			else:
				var x: float = ((1-alpha) * screen_size_1.x) + (alpha * screen_size_2.x)
				var y: float = ((1-alpha) * screen_size_1.y) + (alpha * screen_size_2.y)
				window.content_scale_size = Vector2i(type_convert(x,TYPE_INT),type_convert(y,TYPE_INT))
			if score >= 2 && alpha == 1.:
				next_state = State.GROW_WINDOW_2
		State.GROW_WINDOW_2:
			var alpha = type_convert(state_lifetime_frames, TYPE_FLOAT) * (1./120.) * 0.1
			alpha = min(alpha,1.)
			if (alpha >= 1.):
				window.content_scale_size = Vector2i(screen_size_3)
			else:
				var x: float = ((1-alpha) * screen_size_2.x) + (alpha * screen_size_3.x)
				var y: float = ((1-alpha) * screen_size_2.y) + (alpha * screen_size_3.y)
				window.content_scale_size = Vector2i(type_convert(x,TYPE_INT),type_convert(y,TYPE_INT))
