extends Node2D
var BodyEnterd = false




func _ready() -> void:
	$Player/Player/Camera2D.limit_left = -155
	$Player/Player/Camera2D.limit_top = -475
	$Player/Player/Camera2D.limit_bottom = 55
	$Player/Player/Camera2D.limit_right = 896
	



func _process(delta: float) -> void:
	if BodyEnterd == true:   #ilk şart else e bağlı      !!!DİKKAT
		if Input.is_action_pressed("E") :
			$Player/Player/CanvasLayer/HomePanel.visible = true
		
	else:
		$Player/Player/CanvasLayer/HomePanel.visible = false





func _on_home_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		BodyEnterd = true
		$Player/Player/ActionText.text = "Press %s to enter home" %InputMap.action_get_events("E")[0].as_text()


func _on_home_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		BodyEnterd = false
		$Player/Player/ActionText.text = " "
