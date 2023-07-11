class_name Player
extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0
const HIT_IMPACT = Vector2(0.707 * 600.0, -0.707 * 200.0)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var was_on_floor = false


@onready
var sprite = $AnimatedSprite2D

func _ready():
	set_physics_process(false)
	sprite.connect("animation_finished", animation_finished)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
		if was_on_floor and sprite.animation != "fall" and sprite.animation != "jump":
			sprite.play("fall")
		was_on_floor = false
	else:
		if not was_on_floor:
			sprite.play("land")
		was_on_floor = true

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		sprite.play("jump")

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x > 0:
			if sprite.flip_h == true: sprite.flip_h = false
		elif velocity.x < 0 and sprite.flip_h == false: sprite.flip_h = true
		if is_on_floor() and sprite.animation != "run" and sprite.animation != "jump":
			sprite.play("run")
	elif not direction:
		if sprite.animation == "run" : sprite.play("idle")
		slow()

	move_and_slide()

func slow():
	velocity.x = move_toward(velocity.x, 0, SPEED)

func animation_finished():
	if sprite.animation == "land": sprite.play("idle")

func take_hit():
	get_tree().reload_current_scene()
