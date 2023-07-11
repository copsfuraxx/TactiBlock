class_name Card
extends PanelContainer

var pause = false
var main: Node
var name_key: String
var block: Block

@onready
var _name = $VBoxContainer/Name

func _ready():
	update_name()

func _gui_input(event):
	if pause: return
	if event is InputEventMouseButton and event.button_index == 1:
		main.place_block(self)
		visible = false

func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		update_name()

func init(data: CardData, _main: Node):
	main = _main
	name_key = data.name_key
	block = data.blockPrefab.instantiate()

func update_name():
	_name.text = tr(name_key)
