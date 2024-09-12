extends CharacterBody2D
var _name = "dialogo"
var ativo = false
var anim_name
@export var selfAnim: AnimationPlayer
var animator = AnimationPlayer
const _DIALOG_SCREEN: PackedScene = preload("res://Cenas/dialog_screen.tscn")
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
@onready var _dialog_data: Dictionary = $Node.txt
@onready var _dialog_data_again: Dictionary = $Node.txtAgain

@export_category("Objects")
@export var _hud: CanvasLayer = null
func _ready():
	selfAnim.play("idle_d")
	ChatsLog.chat_ativo = "npc_teste"; #especifica qual o npc do diálogo para uso em outros scripts;
func new_interaction():		
	if _hud.get_child_count() == 0:
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		if ChatsLog.npc_teste.primeira_vez == true:
			_new_dialog.data = _dialog_data
		else:
			_new_dialog.data = _dialog_data_again
		_hud.add_child(_new_dialog)
