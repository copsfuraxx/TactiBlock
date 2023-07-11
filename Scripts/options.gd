extends Panel

@onready
var exit = $Panel/VBoxContainer/Exit

@onready
var credits = $Credits

func _ready():
	exit.connect("pressed", get_tree().quit)

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if credits.visible :
			credits.visible = false
			return
		get_tree().paused = !get_tree().paused
		visible = !visible

func _on_credits_pressed():
	credits.visible = true


func _on_retry_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()


func _on_rich_text_label_meta_clicked(meta):
	OS.shell_open(meta)
