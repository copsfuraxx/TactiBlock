@icon("res://addons/godot/StaticBody2D.png")
class_name Block
extends StaticBody2D


const multiple = 50
const half_multiple = 25

var drag = false

@onready
var collision = $CollisionShape2D

@onready
var buttons = $ChoiceBlock


func _process(_delta):
	if !drag: return
	position = get_global_mouse_position()

func  _input(event):
	if !collision.shape.get_rect().has_point(collision.get_local_mouse_position()):
		if !drag:
			return
	if event is InputEventMouseButton and event.button_index == 1:
		if event.pressed:
			drag = true
		else:
			if drag:
				stop_drag()

func stop_drag():
	var p = Vector2i(get_global_mouse_position())
	p.x = round_to(p.x)
	p.y = round_to(p.y)
	position = p
	drag = false

func round_to(number):
	var n = number % multiple
	return number + (-n if n < half_multiple else multiple - n)

func fix():
	set_process(false)
	set_process_input(false)
	buttons.queue_free()
