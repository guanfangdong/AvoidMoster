extends Node

#输入引用场景
export (PackedScene) var Mob
var score

func _ready():
	randomize()

func get_hit():
	$GameOver.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
	
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_ScoreTimer_timeout():
	score +=1
	$HUD.update_score(score)


func _on_MobTimer_timeout():
	$MobPath/MobSpawnLocation.set_offset(randi())
	var mob = Mob.instance()
	#加上子node
	add_child(mob)
	var direction = $MobPath/MobSpawnLocation.rotation + PI/2
	mob.position = $MobPath/MobSpawnLocation.position
	direction += rand_range(-PI/4,PI/4)
	mob.rotation = direction
	mob.set_linear_velocity(Vector2(rand_range(mob.min_speed, mob.max_speed),0).rotated(direction))

func start_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("ready")
	$GameStart.stream = load("res://sound/game start.ogg")
	$GameStart.play()
