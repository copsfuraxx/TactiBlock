extends PanelContainer

@onready
var lang = $HBoxContainer/OptionButton

@onready
var label = $HBoxContainer/Label

func _ready():
	lang.connect("item_selected", change_lang)
	var i = 0
	for local in TranslationServer.get_loaded_locales():
		lang.add_item(local, i)
		if local == TranslationServer.get_locale(): lang.select(i)
		i += 1
	update_label()

func _notification(what):
	if what == NOTIFICATION_TRANSLATION_CHANGED:
		update_label()

func update_label():
	label.text = tr("LANG") + " : "

func change_lang(index):
	print(TranslationServer.get_locale())
	TranslationServer.set_locale(lang.get_item_text(index))
