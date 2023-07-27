extends CharacterBody2D

func _ready():	
	UpdateLabelText()
	
func _physics_process(delta):
	move_and_collide(Vector2(0, 1)) # Move down 1 pixel per physics frame

func UpdateLabelText():
	var b: String = get_meta("Operator")
	var Power: int = get_meta("Power")
	get_node("PowerLabel").text = b + str(Power)
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !event.pressed:
				SignalBus.emit_signal("math_connect", self)

