extends Node

const MULTIPLE = 50
const HALF_MULTIPLE = 25
const GROUND_MONSTER = preload("res://Scenes/Enemy/mushroom.tscn")
const FLY_MONSTER = preload("res://Scenes/Enemy/ghost.tscn")

var block: Block
var selected_card: Card
var monsters = []
var hand: Array[Card]

@onready var world = $World
@onready var ui = $UI
@onready var camera = $Camera2D
@onready var player = $Player
@onready var tile_map = $TileMap

func _ready():
	$World/End.position.y = randf_range(100.0, 700.0)
	var p = randf_range(100.0, 800.0)
	$World/Start.position.y = p
	player.position.y = p - player.get_node("CollisionShape2D").shape.size.y - 25

func place_block(card: Card):
	selected_card = card
	if block:
		on_choice_block(true)
	else :
		tile_map.position.x = round_to(int(camera.position.x))
	tile_map.visible = true
	block = card.block
	block.position.x += camera.position.x
	block.get_node("ChoiceBlock").connect("cliked", on_choice_block)
	add_child(block)

func on_choice_block(etat:bool):
	tile_map.visible = false
	remove_child(block)
	if etat:
		block.collision.disabled = false
		world.add_child(block)
		block.fix()
		enemy_turn()
		hand.erase(selected_card)
		selected_card.queue_free()
	else:
		block.get_node("ChoiceBlock").disconnect("cliked", on_choice_block)
		selected_card.visible = true
	block = null
	selected_card = null

func enemy_turn():
	var rand = randf()
	if rand <= 0.5:
		spawn_ground_enemy()
	else:
		spawn_fly_enemy()

func spawn_ground_enemy():
	var m = GROUND_MONSTER.instantiate()
	monsters.append(m)
	var shape = m.get_node("CollisionShape2D").shape.get_rect() as Rect2
	m.position.y = block.position.y - shape.size.y
	m.position.x = block.position.x + randf_range(0.0, block.collision.shape.size.x)
	add_child(m)

func spawn_fly_enemy():
	var m = FLY_MONSTER.instantiate()
	monsters.append(m)
	m.player = player
	var shape = m.get_node("Area2D/CollisionShape2D").shape.get_rect() as Rect2
	m.position.y = block.position.y - shape.size.y - 50
	m.position.x = block.position.x + randf_range(0.0, block.collision.shape.size.x)
	add_child(m)

func round_to(number):
	var n = number % MULTIPLE
	return number + (-n if n < HALF_MULTIPLE else MULTIPLE - n)

func _on_end_turn_pressed():
	for card in hand:
		card.pause = true
	player.set_physics_process(true)
	for m in monsters:
		m.start()

func _on_area_2d_body_entered(body:Node):
	if body.is_in_group("Player"):
		get_tree().reload_current_scene()
	elif body.is_in_group("Monster"):
		monsters.erase(body)
		body.queue_free()

func _on_finish_body_entered(_body):
	get_tree().reload_current_scene()
