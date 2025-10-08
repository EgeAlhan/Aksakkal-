extends Control
@onready var Map1 = "res://Scenes/map_1.tscn"



func _ready() -> void:
	pass



func _process(delta: float) -> void:
	pass

func _on_new_game_pressed() -> void:
	$PanelContainer.visible = false
	$DifficultyPanel.visible = true


func _on_easy_pressed() -> void:
	Global.Health = 10
	get_tree().change_scene_to_file(Map1)
	Global.MaxHealth = 10
	
	


func _on_normal_pressed() -> void:
	Global.Health = 5
	get_tree().change_scene_to_file(Map1)
	Global.MaxHealth = 5



func _on_hard_pressed() -> void:
	Global.Health = 3
	get_tree().change_scene_to_file(Map1)
	Global.MaxHealth = 3





func _on_x_diff_pressed() -> void:
	$DifficultyPanel.visible = false
	$PanelContainer.visible = true


func _on_x_home_pressed() -> void:
	$PanelContainer.visible = false




	
