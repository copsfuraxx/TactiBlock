extends Node

@export
var main: Node

@export
var hand: HBoxContainer

@export
var cards: Array[CardData]

@onready
var card_prefab = preload("res://Scenes/card.tscn")

func _ready():
	for card in cards:
		var card_object = card_prefab.instantiate()
		card_object.init(card, main)
		main.hand.append(card_object)
		hand.add_child(card_object)
	queue_free()
