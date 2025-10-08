extends CharacterBody2D
@onready var Home = "res://Scenes/level_0.tscn"

var Gravity = 10

var dir = 0
var Speed = 280
var JumpPower = -300
var OnTheWall = false

var hold = false

var in_water = false

func _ready() -> void:
	if Global.Health == 0:
		get_tree().quit()
	


func _process(delta: float) -> void:
	if Input.is_action_pressed("D"):
		dir = 1
	else:
		dir = 0
	if Input.is_action_pressed("A"):
		dir = -1
	
	if Input.is_action_pressed("W") and is_on_floor() or OnTheWall == true and Input.is_action_just_pressed("W") or in_water == true and Input.is_action_pressed("W"):
		if is_on_floor():
			$AnimatedSprite2D.stop()
			$AnimatedSprite2D.play("Jump")
		if OnTheWall == true:
			dir = -dir #Buraya baq
			$AnimatedSprite2D.play("WallJump")
		velocity.y = JumpPower
	
	if in_water == true and Input.is_action_pressed("S"):
		velocity.y = 100
	
	
	
	if Input.is_action_pressed("Q")and hold == true:
		velocity.y = 0
		Gravity = 0.5
		$AnimatedSprite2D.play("Slide")
	
	
	if in_water == true:
		Gravity = 0.5
		JumpPower = -100
		$O2Bar.visible = true
		
		
		if dir != 0 or Input.is_action_pressed("W"):
			$AnimatedSprite2D.play("Swim")
		
		else:
			$AnimatedSprite2D.play("Fall")
		
		if $O2Bar.value <= 0:
			Global.Health = 0
	
	
	if hold == false and in_water == false:
		JumpPower = -300
		Gravity = 10
		$O2Bar.value = 100
		$O2Bar.visible = false
	
	if dir == 1:
		$AnimatedSprite2D.flip_h = false
	if dir == -1:
		$AnimatedSprite2D.flip_h = true
	
	
	velocity.y += Gravity
	velocity.x = dir * Speed
	move_and_slide()
	
	
	
	#Can
	$ProgressBar/Label.text = str(Global.Health)
	$ProgressBar.value = Global.Health
	$ProgressBar.max_value = Global.MaxHealth
	
	
	_Anim()
	_Brightness()
	
	
	
	
func _Anim():
	if is_on_floor() and in_water == false:
		if dir == 1:
			$AnimatedSprite2D.play("Run")
			
		if dir == 0:
			$AnimatedSprite2D.play("idle")
		if dir == -1:
			$AnimatedSprite2D.play("Run")
			
	
	
	if !is_on_floor() and OnTheWall == false and  hold == false and in_water == false: #fall anim
		if $AnimatedSprite2D.animation != "Jump" and $AnimatedSprite2D.animation != "WallJump":
			$AnimatedSprite2D.play("Fall")
		if $AnimatedSprite2D.animation == "Jump" and !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("Fall")
		if $AnimatedSprite2D.animation == "WallJump" and !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play("Fall")





func _Brightness():
	$CanvasLayer/Brightness.color.a = Global.Brightness * Global.Player_Brightness * 1.6





func _on_wall_area_body_entered(body: Node2D) -> void:
	if body.name == "SarkıtTile":
		hold = true


func _on_wall_area_body_exited(body: Node2D) -> void:
	if body.name == "SarkıtTile":
		hold = false




#Duvardan Zıplama
func _on_jump_area_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		OnTheWall = true


func _on_jump_area_body_exited(body: Node2D) -> void:
	if body.name != "Player":
		OnTheWall = false

#SLİME İÇİN ZIPLAMA
func _on_jumpingarea_body_entered(body: Node2D) -> void:
	velocity.y = -velocity.y


#Nightmarecan
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		Global.Health -= 1
		get_tree().reload_current_scene()

#WATER STUFS
func _on_water_area_body_entered(body: Node2D) -> void:
	if body.name == "Player" and in_water == false:
		in_water = true
		$O2Timer.start()
	


func _on_water_area_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		in_water = false


func _on_o_2_timer_timeout() -> void:
	if in_water == true:
		$O2Bar.value -= 1
		$O2Timer.start()
