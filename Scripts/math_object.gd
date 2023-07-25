extends CharacterBody2D

func _ready():
	SignalBus.connect("math_connect", _on_math_connect)

func _process(delta):
	UpdateLabelText()
	
func _physics_process(delta):
	move_and_collide(Vector2(0, 1)) # Move down 1 pixel per physics frame

func UpdateLabelText():
	var b: String = get_meta("Operator")
	var c: bool = get_meta("isPlayer")
	var Power: int = get_meta("Power")
	if (c):
		b = ""
	get_node("PowerLabel").text = b + str(Power)
	

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if !event.pressed:
				SignalBus.emit_signal("math_connect", self)
				
func _on_math_connect(sender):	
	var c: bool = get_meta("isPlayer")
	if (c == false):
		return false	
	if sender is CharacterBody2D:
		var Power: int = get_meta("Power")
		var NewPower: int = sender.get_meta("Power")
		Power = Power + NewPower
		set_meta("Power", Power)
		sender.queue_free()
	return true

