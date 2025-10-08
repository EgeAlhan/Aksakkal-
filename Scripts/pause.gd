extends Control





func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Esc"):
		get_tree().paused = ! get_tree().paused
		visible = !visible
	
	_BrightnessSetings()


func _on_play_pressed() -> void:
		get_tree().paused = ! get_tree().paused
		visible = !visible


func _on_settings_pressed() -> void:
	$Settings.visible = true


func _on_brightness_settings_pressed() -> void:
	$Settings/Brightness.visible = true




func _BrightnessSetings():
	$Settings/Brightness/BrightnessValue.text = str($Settings/Brightness/BrightnessSlider.value * 200)#
	Global.Player_Brightness = 1 - $Settings/Brightness/BrightnessSlider.value#ters olduğu için max değerden çıkar
	


func _on_settings_close_pressed() -> void:
	$Settings.visible = false
	


func _on_brightness_close_pressed() -> void:
	$Settings/Brightness.visible = false


func _on_key_bind_pressed() -> void:
	$KeyBinds.visible = true


func _on_key_bind_close_pressed() -> void:
	$KeyBinds.visible = false
