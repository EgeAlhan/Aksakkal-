extends RigidBody2D

var in_vagon = false
var CutScene = false


func _process(delta: float) -> void:
	_VagonMovement()
	
	





func _on_vagon_area_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		in_vagon = true


func _on_vagon_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_vagon = false


func _VagonMovement():
	if in_vagon == true and Input.is_action_just_pressed("LeftClick") and CutScene == false:
		linear_velocity.x += 10
		if linear_velocity.x >= 350:
			linear_velocity.x = 350
		$AnimatedSprite2D.play("Movement")
