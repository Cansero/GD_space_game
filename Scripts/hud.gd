extends CanvasLayer

signal start_game


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()


func update_score(num):
	$Score.text = str(num)


func reset():
	$Score.text = "0"
	$StartButton.show()
