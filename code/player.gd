extends Area2D

# player 
# export就是public unity里面的
export (int) var speed = 150
var screensize

# 像bool
signal hit

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _ready():
	#拿到Screensize
	screensize = get_viewport_rect().size
	hide()
	
#相当如unity里的update
func _process(delta):
	
	var velocity = Vector2()
	
	#检查按键做出跟新
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	# 长度大于0则证明物体正在移动
	if velocity.length()>0:
		#对角线移动
		velocity = velocity.normalized() * speed
		# $是get_node的意思
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity*delta
	# clamp可以限制移动范围
	position.x = clamp(position.x,0,screensize.x)
	position.y = clamp(position.y,0,screensize.y)
	
	if velocity.x !=0 :
		$AnimatedSprite.animation  = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x<0
		
	elif velocity.y !=0 :
		$AnimatedSprite.animation  = "up"
		$AnimatedSprite.flip_v = velocity.y>0


func _on_Player_body_entered(body):
	emit_signal("hit")
	hide()
	#让它不继续撞
	$CollisionShape2D.disabled = true

