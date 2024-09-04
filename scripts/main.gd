extends Node2D
signal change_character
@export var _hud: CanvasLayer = null
var ativo = false
var seguidores_ = ["Seguidor","Seguidor2","Seguidor3" ]
@onready var alvo: = $Personagem
const menu: PackedScene = preload("res://Cenas/menu.tscn")
func _ready():
	party_ativo()
	print($Seguidor.party_pos)
	print($Seguidor2.party_pos)
	print($Seguidor3.party_pos)
func _input(event):
	if Input.is_action_just_pressed("1"):
		if alvo.name_ != "caleb":
			change_2("caleb")
	elif Input.is_action_just_pressed("2"):
		if alvo.name_ != "morgana":
			change_2("morgana")
	elif Input.is_action_just_pressed("3"):
		if alvo.name_ != "teste":
			change_2("teste")
	elif Input.is_action_just_pressed("4"):
		if alvo.name_ != "teste2":
			change_2("teste2")
	if Input.is_action_just_pressed("x"):
		var _menu = menu.instantiate()
		if _hud.get_child_count() == 0:
			_hud.add_child(_menu)
func change_(seguidor):	
	var temp_txt
	var temp_name
	#name
	temp_name = seguidor.name_
	seguidor.name_ = alvo.name_
	alvo.name_ = temp_name
	#sprite
	temp_txt = seguidor.textura
	seguidor.textura = alvo.textura
	alvo.textura = temp_txt
	emit_signal("change_character")
	
func change_2(tag):
	#verifica o nome do personagem e se ele está ativo
	for seg in seguidores_:
		if $".".get_node(seg).name_ == tag and $".".get_node(seg).ativo:
			change_($".".get_node(seg))
func party_ativo():
	#desativa os membros com o .ativo == false, e reposiciona os demais
	for seg in seguidores_:
		if $".".get_node(seg).ativo != true:
			$".".get_node(seg).hide()
			for seg_ in seguidores_:
				if $".".get_node(seg_).ativo and $".".get_node(seg_).party_pos >= $".".get_node(seg).party_pos:
					$".".get_node(seg_).party_pos -=1



