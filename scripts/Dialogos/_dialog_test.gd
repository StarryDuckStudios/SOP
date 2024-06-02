extends CharacterBody2D
class_name Level
var ativo = false
var anim_name
@onready var self_anim = self.get_node("Sprite2D")
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
	"Area R" : "walk_l_3",
	"Area L" : "walk_r_3",
	"Area U" : "walk_d_3",
	"Area D" : "walk_up_3",
}
var _dialog_data: Dictionary = {
	0: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem?",
			"En": "Hello, how are you?"
		},
		"title" : "Calebo",
		"type" : "fala"
	},
	1: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem?",
			"En": "I'm fine thank you"
		},
		"dialog_1" : {
			"pt": "Olá, tudo bem?",
			"En": "I hate you"
		},
		"dialog_2" : {
			"pt": "Olá, tudo bem?",
			"En": "Love u"
		},
		"title" : "Calebo",
		"type" : "resposta"
	},
	2: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem? 1",
			"En": "So, is it, by"
		},
		"dialog_1" : {
			"pt": "Olá, tudo bem?",
			"En": "I hate you too"
		},
		"dialog_2" : {
			"pt": "Olá, tudo bem?",
			"En": "Weirdo"
		},
		"title" : "Calebo",
		"type" : "fala"
	},
	3: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem 2?",
			"En": "So, is it, by"
		},
		"dialog_1" : {
			"pt": "Olá, tudo bem?",
			"En": "I hate you too"
		},
		"dialog_2" : {
			"pt": "Olá, tudo bem?",
			"En": "Weirdo"
		},
		"title" : "Calebo",
		"type" : "fala"
	},
	4: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem? 3",
			"En": "So, is it, by"
		},
		"dialog_1" : {
			"pt": "Olá, tudo bem?",
			"En": "I hate you too"
		},
		"dialog_2" : {
			"pt": "Olá, tudo bem?",
			"En": "Weirdo"
		},
		"title" : "Calebo",
		"type" : "fala"
	},
	5: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Olá, tudo bem? 4",
			"En": "So, is it, by"
		},
		"dialog_1" : {
			"pt": "Olá, tudo bem?",
			"En": "I hate you too"
		},
		"dialog_2" : {
			"pt": "Olá, tudo bem?",
			"En": "Weirdo"
		},
		"title" : "Calebo",
		"type" : "fala"
	}
}
var _dialog_data_again: Dictionary = {
	0: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Você denovo?",
			"En": "You again?",
			},
		"title" : "Calebo",
		"type" : "fala"
	},
	1: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Você denovo?",
			"En": "Fuck you",
			},
		"title" : "Calebo",
		"type" : "fala"
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
		var _new_dialog: DialogScreen = _DIALOG_SCREEN.instantiate()
		if ChatsLog.npc_teste.primeira_vez == true:
			_new_dialog.data = _dialog_data
		else:
			_new_dialog.data = _dialog_data_again
		await animator.animation_finished
		_hud.add_child(_new_dialog)
	
func Ativo(body):
	if body.get_parent().name == "Personagem":
		anim_name = body
		ativo = true
func Inativo(body):
	if body.get_parent().name == "Personagem":
		ativo = false
