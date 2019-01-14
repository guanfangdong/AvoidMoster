extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MsgTimer.start()
	
func show_game_over():
	show_message("Game Over")
	yield($MsgTimer, "timeout")
	$StartButton.show()
	$MessageLabel.text = "继续玩啊？"
	$MessageLabel.show()
	
func update_score(score):
	$ScoreLabel.text = "Score: " + str(score)

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")


func _on_CanvasLayer_start_game():
	$MessageLabel.hide()