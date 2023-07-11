extends AnimatedSprite2D


const SPEED = 150.0

var player : Player
var velocity = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	var direction = position.direction_to(player.position)
	move_and_slide(direction * SPEED, delta)

func move_and_slide(v: Vector2, delta: float):
	velocity = (velocity + v ) / 2
	position += velocity * delta

func start():
	set_physics_process(true)

func _on_area_2d_body_entered(body: PhysicsBody2D):
	body.call_deferred("take_hit")
