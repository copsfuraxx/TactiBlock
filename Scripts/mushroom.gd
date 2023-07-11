extends CharacterBody2D


const SPEED = 200.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player : Player

@onready var sprite = $AnimatedSprite2D


func _ready():
	set_physics_process(false)

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if !player:
		move_and_slide()
		return

	var direction = 1.0 if position.x < player.position.x else -1.0
	if direction == -1.0:
		if !sprite.flip_h: sprite.flip_h = true
	elif sprite.flip_h:
		sprite.flip_h = false
	
	velocity.x = direction * SPEED

	move_and_slide()

func start():
	set_physics_process(true)
	$Area2D2/CollisionShape2D.disabled = false

func _on_area_2d_body_entered(body: PhysicsBody2D):
	body.call_deferred("take_hit")

func _on_area_2d_2_body_entered(body):
	player = body
	sprite.play("Run")
