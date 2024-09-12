extends Sprite2D
@onready var tile_map = $"..".tile_map
@onready var sprite_2d = $Sprite2D
@onready var ray_cast_2d = $RayCast2D
@onready var animator = $Sprite2D/animate/AnimationPlayer
var array_movement = []
var array_animation = []
var is_moving = false
func _physics_process(delta):
	if !is_moving:
		return
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)
func _process(delta):
	if ray_cast_2d.is_colliding():
		var colider = ray_cast_2d.get_collider()
		if colider._name == "mercador" and Input.is_action_just_pressed("z"):
			colider.new_interaction()
		elif colider._name == "dialogo" and Input.is_action_just_pressed("z"):
			colider.new_interaction()
	if is_moving:
		return
	if Input.is_action_pressed("ui_up"):
		move(Vector2.UP, 'u')
	elif Input.is_action_pressed("ui_down"):
		move(Vector2.DOWN, 'd')
	elif Input.is_action_pressed("ui_right"):
		move(Vector2.RIGHT, 'r')
	elif Input.is_action_pressed("ui_left"):
		move(Vector2.LEFT, 'l')
	else:
		if array_animation.size() > 3:
			animator.play("idle_" + array_animation[- 1])
			$"../Seguidor".animator.play("idle_" + array_animation[-2])
			$"../Seguidor2".animator.play("idle_" + array_animation[-3])
			$"../Seguidor3".animator.play("idle_" + array_animation[-4])

func move(direction: Vector2, anim):
	#Conseguir o tile atual e o tile alvo
	var current_tile: Vector2i = tile_map.local_to_map(global_position)
	var target_tile: Vector2i = Vector2i(
		current_tile.x + direction.x,
		current_tile.y + direction.y,
	)
	#Conseguir informação do tile
	var tile_data: TileData = tile_map.get_cell_tile_data(0 , target_tile)
	if tile_data.get_custom_data("walkable") == false:
		return
	ray_cast_2d.target_position = direction * 16
	ray_cast_2d.force_raycast_update()
	if ray_cast_2d.is_colliding():
		return
	
	array_movement.append(target_tile)
	array_animation.append(anim)
	if array_movement.size() > 3 :
		$"../Seguidor"._on_player_movement(array_movement[-2], array_animation[-2])
		$"../Seguidor2"._on_player_movement(array_movement[-3], array_animation[-3])
		$"../Seguidor3"._on_player_movement(array_movement[-4], array_animation[-4])
	is_moving = true
	global_position = tile_map.map_to_local(target_tile)
	animator.play("walk_" + anim)
	sprite_2d.global_position = tile_map.map_to_local(current_tile)
