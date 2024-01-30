extends CharacterBody2D

var curr_pos = [32,32]
var velo = 16
var continue_ = true
var movimentos = []
var u = true
var d = true
var r = true
var l = true

@export var pos = 1
var animator
func _ready():
	animator = $MorganaAnimator
	$Sprite2D.texture = load("res://sprites/Morgana_SpriteSheet.png")
	position = Vector2(32,32)
func _input(event):	
	if continue_ == true and pos == 1:
		if Input.is_action_pressed("ui_right") and r:
			curr_pos[0] += velo
			animation("r")
			tween()
		elif Input.is_action_pressed("ui_left") and l:
			curr_pos[0] -= velo
			animation("l")
			tween()
		elif Input.is_action_pressed("ui_down") and d:
			curr_pos[1] += velo
			animation("d")
			tween()
		elif Input.is_action_pressed("ui_up") and u:
			curr_pos[1] -= velo
			animation("u")
			tween()
func tween():
	var tween = create_tween()
	tween.tween_property($".", "position", Vector2(curr_pos[0], curr_pos[1]), 0.5)
	movimentos.append(Vector2(curr_pos[0], curr_pos[1]))
	continue_ = false
	await get_tree().create_timer(0.5).timeout
	continue_ = true
	
func animation(direction):
	animator.play("walk_" + direction)
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

