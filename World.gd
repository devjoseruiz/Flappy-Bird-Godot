extends Node2D

onready var hud = $HUD
onready var obstacle_spawner = $ObstacleSpawner
onready var ground = $Ground
onready var menu_layer = $MenuLayer

const SAVES_PATH = "user://savedate.save"

var score = 0 setget set_score
var highscore = 0

func _ready():
	obstacle_spawner.connect("obstacle_created", self, "_on_obstacle_created")
	load_highscore()

func new_game():
	self.score = 0
	obstacle_spawner.start()

func _on_obstacle_created(obs):
	obs.connect("score", self, "player_score")

func player_score():
	self.score += 1

func set_score(new_score):
	score = new_score
	hud.update_score(score)

func _on_Player_died():
	game_over()

func game_over():
	obstacle_spawner.stop()
	ground.get_node("AnimationPlayer").stop()
	get_tree().call_group("obstacles", "set_physics_process", false)
	
	if score > highscore:
		highscore = score
		save_highscore()
	
	menu_layer.init_gameover_menu(score, highscore)

func _on_MenuLayer_start_game():
	new_game()

func save_highscore():
	var save_data = File.new()
	save_data.open(SAVES_PATH, File.WRITE)
	save_data.store_var(highscore)
	save_data.close()

func load_highscore():
	var load_data = File.new()
	if load_data.file_exists(SAVES_PATH):
		load_data.open(SAVES_PATH, File.READ)
		highscore = load_data.get_var()
		load_data.close()
