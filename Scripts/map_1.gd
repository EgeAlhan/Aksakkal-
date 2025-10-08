extends Node2D

@onready var Map2 = "res://Scenes/map_2.tscn"


func _ready() -> void:
	$Player/Player/Camera2D.limit_left = -158
	$Player/Player/Camera2D.limit_top = -480
	$Player/Player/Camera2D.limit_bottom = 64
	$Player/Player/Camera2D.limit_right = 2560
	
	
	$Player/Player/CanvasLayer/Notes.visible = true
	$Player/Player/CanvasLayer/Notes/PanelContainer/Noteslabel.text = "Check the settings \n menu for controls."

func _on_death_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.Health -= 1
		get_tree().reload_current_scene()


func _on_end_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file(Map2)
