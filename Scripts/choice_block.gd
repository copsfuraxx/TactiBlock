extends HBoxContainer


signal cliked(etat: bool)


func _on_validate_pressed():
	emit_signal("cliked", true)

func _on_cancel_pressed():
	emit_signal("cliked", false)
