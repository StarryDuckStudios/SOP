extends CharacterBody2D
var ativo = false
var anim_name
@onready var self_anim = self.get_node("Sprite2D")
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
	"Area R" : "walk_l_3",
	"Area L" : "walk_r_3",
	"Area U" : "walk_d_3",
	"Area D" : "walk_up_3",
}
var marketer_data: Dictionary = {
	"Item_1" = {
		"pt" : "Poção de cura",
		"En" : "Life potion",
		"qtd" : 5,
		"preco" : 200
	},
	"Item_2" = {
		"pt" : "Poção de Mana",
		"En" : "Mana potion",
		"qtd" : 2,
		"preco" : 100
	}
}
@export_category("Objects")
@export var _hud: CanvasLayer = null
func _ready():
	ChatsLog.chat_ativo = "npc_teste"; #especifica qual o npc do diálogo para uso em outros scripts;
func _input(event):
	if Input.is_action_just_pressed("z") and ativo and _hud.get_child_count() == 0:
		animator = anim_name.get_parent().get_node("CalebAnimation")
		animator.play(traduz_pos[anim_name.name]) #Faz o player virar para o npc
		
		#Gambiarra pro npc virar pro personagem
		self_anim.texture = load("res://sprites/Caleb/"+traduz_self_pos[anim_name.name] + ".png")
		var _new_dialog = _DIALOG_SCREEN.instantiate()
		_new_dialog.data = marketer_data
		_hud.add_child(_new_dialog)
	
func Ativo(body):
	if body.get_parent().name == "Personagem":
		anim_name = body
		ativo = true
func Inativo(body):
	if body.get_parent().name == "Personagem":
		ativo = false
