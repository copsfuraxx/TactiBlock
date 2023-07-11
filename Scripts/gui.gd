extends Panelqqqd

@onready
var turn = $VBoxContainer/Turn

# Called when the node enters the scene tree for the first time.
func _ready():
	update_turn()

func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		update_turn()

func  update_turn():
	turn.text = tr("TURN") % 0
qzdqzdqzdqsd qsdq
