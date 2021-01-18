extends CanvasLayer

signal start_game

onready var start_message = $MainMenu/StartMessage
onready var tween = $Tween
onready var score_label = $GameOverMenu/VBoxContainer/ScoreLabel
onready var highscore_label = $GameOverMenu/VBoxContainer/HighScoreLabel
onready var gameover_menu = $GameOverMenu

var game_started = false

func _input(event):
	if event.is_action_pressed("flap") && !game_started:
		emit_signal("start_game")
		game_started = true
		tween.interpolate_property(start_message, "modulate:a", 1, 0, 0.5)
		tween.start()

func init_gameover_menu(score, highscore):
	score_label.text = "SCORE: " + str(score)
	highscore_label.text = "BEST SCORE: " + str(highscore)
	gameover_menu.visible = true

func _on_RestartButton_pressed():
	get_tree().reload_current_scene()
