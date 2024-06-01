extends Node
var consumiveis = {
	"Item_1" = {
		"portugues" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"ingles" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" ={
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
		},
	"Item_2" = {
		"portugues" = {
			"name" : "Poção de mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"ingles" = {
			"name" : "Mana Potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" ={
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
		}
	}
var itens_chave = {
	"Item_1" = {
		"portugues" = {
			"name" : "Chave",
			"descricao" : "uma chave misteriosa"
		},
		"ingles" = {
			"name" : "Key",
			"descricao" : "a mistyrious key"
		},
		"propriedades" ={
			"quantidade" : 1,
			"texture" : "res://sprites/itens/key-bluee.png"
		}
		}
	}
var equipaveis = {
	"Item_1" = {
		"portugues" = {
			"name" : "Faca",
			"descricao" : "Um objeto de cozinha extremamaente cortante"
		},
		"ingles" = {
			"name" : "Knife",
			"descricao" : "A kitchen utensil extremely sharpnes"
		},
		"propriedades" ={
			"quantidade" : 1,
			"texture" : "res://sprites/itens/key-bluee.png"
		}
		}
}
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
