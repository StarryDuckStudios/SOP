extends CharacterBody2D
var _name = "mercador"
var ativo = false
var anim_name
@export var selfAnim : AnimationPlayer
@export var modifica_preco: float
var animator = AnimationPlayer
const _DIALOG_SCREEN: PackedScene = preload("res://Cenas/marketer.tscn")
var traduz_pos = {
	"Area R" : "idle_r",
	"Area L" : "idle_l",
	"Area U" : "idle_u",
	"Area D" : "idle_d",
}
#Gambiarra pro npc virar pro personagem
var traduz_self_pos = {
	"Area R" : "idle_l",
	"Area L" : "idle_r",
	"Area U" : "idle_d",
	"Area D" : "idle_u",
}
@onready var marketer_data: Dictionary = $Node.txt
@onready var falas_aleatorias: Dictionary =$Node.txtDiag
@export_category("Objects")
@export var _hud: CanvasLayer = null
func _ready():
	for key in marketer_data.keys():
		marketer_data[key]['propriedades']['preco'] *= modifica_preco
	ChatsLog.chat_ativo = "npc_teste"; #especifica qual o npc do diálogo para uso em outros scripts;


func new_interaction():
	if _hud.get_child_count() == 0:
		var _new_dialog = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = marketer_data
		_new_dialog.dialogo_dicionario = falas_aleatorias
		_hud.add_child(_new_dialog)
