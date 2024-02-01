extends CharacterBody2D

var curr_pos = [32,32]
var velo = 16
var continue_ = true
var movimentos = []
var move_historic = []
@export var name_ = ""
var u = true
var d = true
var r = true
var l = true
var textura = "res://sprites/Caleb.png"
signal seguir
@export var pos = 1
@export var animator: AnimationPlayer

func _ready():
	animator = $CalebAnimation
	name_ = "caleb"
	$Sprite2D.texture = load(textura)
	position = Vector2(32,32)
func _input(event):
	if continue_ == true:
		if Input.is_action_pressed("ui_right"):
			if r:
				curr_pos[0] += velo
				animation("r")
				tween()
			else:
				animator.play("idle_r")
		elif Input.is_action_pressed("ui_left"):
			if l:
				curr_pos[0] -= velo
				animation("l")
				tween()
			else:
				animator.play("idle_l")
		elif Input.is_action_pressed("ui_down"):
			if d:
				curr_pos[1] += velo
				animation("d")
				tween()
			else:
				animator.play("idle_d")
		elif Input.is_action_pressed("ui_up"):
			if u:
				curr_pos[1] -= velo
				animation("u")
				tween()
			else:
				animator.play("idle_u")
func tween():
	var tween = create_tween()
	tween.tween_property($".", "position", Vector2(curr_pos[0], curr_pos[1]), 0.5)
	movimentos.append(Vector2(curr_pos[0], curr_pos[1]))
	#limpar lista
	if movimentos.size() > 4:
		movimentos.pop_front()
	continue_ = false
	emit_signal("seguir")
	await get_tree().create_timer(0.5).timeout
	continue_ = true

func animation(direction):
	animator.play("walk_" + direction)
	move_historic.append(direction)
	#limpar lista
	if move_historic.size() > 4:
		move_historic.pop_front()
	await animator.animation_finished
	animator.play("idle_" + direction)
		
func U_obstacle(area):
	u = false
	print("u")
func U_free(area):
	u = true
	print("uf")
func D_obstacle(area):
	d = false
	print("d")
func D_free(area):
	d = true
	print("df")
func R_obstacle(area):
	r = false
	print("r")
func R_free(area):
	r = true
	print("rf")
func L_free(area):
	l = true
	print("lf")
func L_obstacle(area):
	l = false
	print("l")

func change_character():
	$Sprite2D.texture = load(textura)
