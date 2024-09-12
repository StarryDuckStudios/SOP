extends Node2D
var data = InvGlobal.ataques
@onready var animator = $AnimationPlayer
@export var nome = "Genérico"
@export var lvl = 1
@export var max_hp = 100
@export var hp = 100
@export var atk = 15
@export var def = 20
@export var vel  = 10
var move1 = data['fireball']
var move2 = data['shield']
var move3 = data["heal"]
var move4 = data['ice_ray']
var ataques = [move1,move2,move3,move4]

var savecontrol = false
func action():
	var atacante = get_node("../../ActionBar/actionbarcontainer/"+ get_node("../../background")._atacante)
	var _action = [self.name, get_node("../../background")._atacante, get_node("../../background")._spell]
	var _action_bar = $"../../ActionBar"
	get_node("../../background").ataques.append(_action)
	print(get_node("../../background").ataques)
	$"../../ActionBar/SpellContainer/spellbar".back()
	get_node("../../ActionBar/actionbarcontainer/"+ get_node("../../background")._atacante +"/Action/Actions").back()
	atacante.atacou = true
	_action_bar.save_control = []
	_action_bar.caminho_volta = []
	_action_bar.control = 0
	atualiza_info(atacante)
	_action_bar.atualiza_caminho("","actionbarcontainer")
	
	#VERIFICA SE O TURNO JA ACABOU
	get_node("../../background").verifica_atacantes()
func atualiza_info(obj):
	var mana = InvGlobal.personagens[get_node("../../background")._atacante].mana
	mana -= InvGlobal.ataques[get_node("../../background")._spell].custo_mana
	obj.get_node("info/mana").value = mana 
	
