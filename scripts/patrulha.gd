extends CharacterBody2D
@export var cordA: Vector2
@export var cordB: Vector2
var alvo
var personagem
var segueAlvo = false
@onready var tilemap = $"../TileMap"
@onready var animation_tree = $AnimationTree
@onready var _state_machine = animation_tree["parameters/playback"]
var current_path: Array[Vector2i] = []
var previous_position: Vector2 = Vector2.ZERO

func _ready():
	previous_position = global_position
	patrulha()
func _physics_process(delta):
	#Segue infinitamente
	#alvo = $"../Personagem".global_position
	#segue() 
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

func area_entered(body):
	if body.get_parent().name == "Personagem":
		personagem = body
		alvo = body.get_parent().global_position
		segueAlvo = true

func animate() -> void:
	previous_position = global_position
	await get_tree().create_timer(0.01).timeout 
	var velocidade = global_position - previous_position
	animation_tree["parameters/walk/blend_position"] = velocidade
	if velocidade.length() > 1:
		_state_machine.travel("walk")
	else:
		_state_machine.travel("idle")

func patrulha():
	if global_position.distance_to(cordA) < 10:
		segue(cordB)
	else:
		segue(cordA)


func patrulha_timer():
	if !segueAlvo:
		patrulha()
