extends Node2D
@onready var Home = "res://Scenes/level_0.tscn"


var in_vagon = false #vagonun içinde misin
var CutScene = false
var NM_Speed = 2
func _ready() -> void:
	$Player/Player/Camera2D.limit_left = -160
	$Player/Player/Camera2D.limit_bottom = 64
	$Player/Player/Camera2D.limit_top = -495
	$Player/Player/Camera2D.limit_right = 12109
	
	$Player/Player/CanvasLayer/Notes.visible = true
	$Player/Player/CanvasLayer/Notes/PanelContainer/Noteslabel.text = "The green area makes you jump. \nThe higher it is, \n the higher it throws you."


func _process(delta: float) -> void:
	if  $Nightmare.visible == true:
		$Nightmare.position.x += NM_Speed
		
		
	if $Player/Player/CanvasLayer/Notes/PanelContainer/Next.button_pressed:
		$Player/Player/CanvasLayer/Notes/PanelContainer/Noteslabel.text = "The nightmare is coming \n, run away!\n Left-click to move \nthe wagon forward. "







func _on_start_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$StartArea.queue_free()
		$Nightmare.visible = true
		$Nightmare.play("default")


func _on_spd_8_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 5


func _on_spd_7_area_2_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 5.8


func _on_spd_2_area_3_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 2


func _on_gravity_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$Vagon.gravity_scale = 1


func _on_spd_2_area_4_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 5


func _on_spd_2_area_5_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 5.8


func _on_nightmarequeue_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		NM_Speed = 0.5
		


#düşerek ölme alanı

func _on_buttomof_map_area_body_entered(body: Node2D) -> void:
	if body.name == "Vagon":
		$Vagon.queue_free()
	if body.name == "Player":
		Global.Health -= 1
		get_tree().reload_current_scene()


func _on_end_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		get_tree().change_scene_to_file(Home)
