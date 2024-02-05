extends CharacterBody2D

var curr_pos = [0,0]
var velo = 16
var continue_ = true
var movimentos = []
var move_historic = []
var armazena = []
@export var name_ = ""
var u = true
var d = true
var r = true
var l = true
var textura = "res://sprites/Caleb.png"
signal seguir
@export var pos = 1
@export var animator: AnimationPlayer
func _process(delta):
	if move_historic.size() > 100:
		print(move_historic)
func _ready():
	animator = $CalebAnimation
	name_ = "caleb"
	$Sprite2D.texture = load(textura)
	position = Vector2(0,0)
func _input(event):
	if continue_ == true:
		if Input.is_action_pressed("ui_right"):
			if r:
				action(0, 1, "r")
				print("a")
			else:
				animator.play("idle_r")
		elif Input.is_action_pressed("ui_left"):
			if l:
				action(0, -1, "l")
			else:
				animator.play("idle_l")
		elif Input.is_action_pressed("ui_down"):
			if d:
				action(1, 1, "d")
			else:
				animator.play("idle_d")
		elif Input.is_action_pressed("ui_up"):
			if u:
				action(1, -1, "u")
			else:
				animator.play("idle_u")
	elif continue_ == false:
		if Input.is_action_just_pressed("ui_right"):
			if r and armazena.size() == 0:
				armazena.append_array([0,1,"r",r])
		if Input.is_action_just_pressed("ui_left"):
			if r and armazena.size() == 0:
				armazena.append_array([0,-1,"l",l])
		if Input.is_action_just_pressed("ui_down"):
			if r and armazena.size() == 0:
				armazena.append_array([1,1,"d",d])
		if Input.is_action_just_pressed("ui_up"):
			if r and armazena.size() == 0:
				armazena.append_array([1,-1,"u",u])
func tween():
	var tween = create_tween()
	tween.tween_property($".", "position", Vector2(curr_pos[0], curr_pos[1]), 0.5)
	movimentos.append(Vector2(curr_pos[0], curr_pos[1]))
	tween.connect("finished", on_tween_finished)
	#limpar lista
	if movimentos.size() > 4:
		movimentos.pop_front()
	continue_ = false
	emit_signal("seguir")

func animation(direction):
	animator.play("walk_" + direction)
	move_historic.append(direction)
	#limpar lista
	if move_historic.size() > 4:
		move_historic.pop_front()
	await animator.animation_finished
	animator.play("idle_" + direction)
	
func action(posicao,sentido, direction):
	curr_pos[posicao] += velo * sentido
	animation(direction)
	tween()
func on_tween_finished():
	continue_ = true
	await get_tree().create_timer(0.1)
	if armazena.size() == 4 and armazena[2] != move_historic[move_historic.size() - 1]:
		mov_suave(l,"l")
		mov_suave(r,"r")
		mov_suave(u,"u")
		mov_suave(d,"d")
	armazena.clear()
func mov_suave(dir,dir_str):
	if armazena[2] == dir_str:
			if dir:
				print(dir_str)
				action(armazena[0], armazena[1], armazena[2])
func U_obstacle(area):
	u = false
func U_free(area):
	u = true
func D_obstacle(area):
	d = false
func D_free(area):
	d = true
func R_obstacle(area):
	r = false
func R_free(area):
	r = true
func L_free(area):
	l = true
func L_obstacle(area):
	l = false
func change_character():
	$Sprite2D.texture = load(textura)
