extends RigidBody2D

export (int) var min_speed
export (int) var max_speed
var mob_types = ["walk", "swim", "fly"]

func _ready():
	$AnimatedSprite.animation = mob_types[randi()%mob_types.size()]
	$AnimatedSprite.play()

func _on_VisibilityNotifier2D_screen_exited():
	#消失node
	queue_free();

