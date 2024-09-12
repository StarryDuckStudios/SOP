extends CharacterBody2D
@export var cordA: Vector2
@export var cordB: Vector2
@onready var lista = [cordA, cordB]
var patrulha_cont = 0;
var _name
var alvo
var personagem
var segueAlvo = false
@onready var tilemap = $"../TileMap"
@onready var animation_tree = $AnimationTree
@onready var _state_machine = animation_tree["parameters/playback"]
var current_path: Array[Vector2i] = []
var previous_position: Vector2 = Vector2.ZERO
var stop = false
func _ready():
	previous_position = global_position
func _physics_process(delta):
	if not stop:
		animate()
		if segueAlvo == true:
			alvo = personagem.global_position
			segue(alvo)
			if global_position.distance_to(alvo) < 20:
				segueAlvo = false
			
		if current_path.is_empty():
			return
			
		var target_position = tilemap.map_to_local(current_path.front())
		global_position = global_position.move_toward(target_position, 100 * delta)
		if global_position.distance_to(target_position) < 1:
			current_path.pop_front()
func _unhandled_input(event):
	pass

func segue(obj):
	var click_position = obj
	if tilemap.is_point_walkable(click_position):
		current_path = tilemap.astar.get_id_path(
			tilemap.local_to_map(global_position),
			tilemap.local_to_map(click_position)
		).slice(1)
func animate() -> void:
	previous_position = global_position
	await get_tree().create_timer(0.01).timeout 
	var velocidade = global_position - previous_position
	animation_tree["parameters/walk/blend_position"] = velocidade
	if velocidade.length() > 1:
		_state_machine.travel("walk")
	else:
		_state_machine.travel("idle")

func patrulha(x):
	segue(x)
	print("aaa")


func patrulha_timer():
	if !segueAlvo:
		if patrulha_cont > (lista.size() - 1):
			patrulha_cont = 0
		patrulha(lista[patrulha_cont])
		patrulha_cont += 1


func body_entered(body):
	print(body)
	if body.get_parent().name == "Player":
		personagem = body
		alvo = body.get_child(0).global_position
		segueAlvo = true


func _on_area_2d_2_area_entered(body):
	if body.get_parent().name == "Player":
		stop = true
		_state_machine.travel("idle")
		await get_tree().create_timer(2).timeout
		stop = false
