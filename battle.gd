extends Node2D
var _new : PackedScene = preload("res://Cenas/Enemys/Enemy1.tscn")
var _new2: PackedScene = preload("res://Cenas/Enemys/Enemy2.tscn")
var _new3: PackedScene
var _new4: PackedScene
var _new5: PackedScene
var _new6: PackedScene
var lista = [_new, _new2, _new, _new2]
var cont = 1
var formacao1 = [Vector2(788,293)]
var formacao2 = [Vector2(834,208), Vector2(800, 400)]
var formacao3 = [Vector2(900,150), Vector2(750, 278), Vector2(890, 400)]
var formacao4 = [Vector2(960,130), Vector2(750, 178), Vector2(750, 378), Vector2(960, 450)]
func _ready():
	spawna(lista)
	seta_aliado()
func cria_inimigo(pos:Vector2 ,obj,nome):
	var insta = obj.instantiate()
	var hp_bar = $hp.duplicate()
	insta.add_child(hp_bar)
	insta.name = nome
	hp_bar.position = Vector2(-90,-110)
	hp_bar.scale = Vector2(0.1,0.1)
	hp_bar.max_value = insta.max_hp
	hp_bar.value = insta.hp
	$Enemys.add_child(insta)
	insta.global_position = pos
	
func spawna(array):
	for item in array:
		var form
		if item != null:
			if array.size() == 1:
				form = formacao1
			elif array.size() == 2:
				form = formacao2
			elif array.size() == 3:
				form = formacao3
			elif array.size() == 4:
				form = formacao4
			cria_inimigo(form[cont - 1],item, "enemy" + str(cont))
			cont += 1
func seta_aliado():
	for child in get_node("ActionBar/actionbarcontainer").get_children():
		if child.visible:
			child.get_node('info/hp').max_value = InvGlobal.personagens[child.name].max_hp
			child.get_node('info/hp').value = InvGlobal.personagens[child.name].hp
			child.get_node('info/mana').max_value = InvGlobal.personagens[child.name].max_mana
			child.get_node('info/mana').value = InvGlobal.personagens[child.name].mana
