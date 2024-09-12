extends Sprite2D
@onready var tile_map = $"..".tile_map
@export var sprite_2d: Sprite2D
@export var animator: AnimationPlayer
@onready var player_ref = $"../Player"
func _physics_process(delta):
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)
func move(target_tile):
	#Conseguir o tile atual e o tile alvo
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	#Conseguir informação do tile
	var tile_data: TileData = tile_map.get_cell_tile_data(0 , target_tile)
	global_position = tile_map.map_to_local(target_tile)
	#Mover o player


func _on_player_movement(array_movement, anim):
	var armazena = global_position
	move(array_movement)
	animator.play("walk_" + anim)
	sprite_2d.global_position = armazena
	
	
