extends Node
var dinheiro = 0
var consumiveis = {
	"Item_1" = {
		"pt" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"En" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" ={
			"preco" : 50,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
		},
	"Item_2" = {
		"pt" = {
			"name" : "Poção de mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"En" = {
			"name" : "Mana Potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" ={
			"preco" : 50,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
		}
	}
var itens_chave = {
	"Item_1" = {
		"pt" = {
			"name" : "Chave",
			"descricao" : "uma chave misteriosa"
		},
		"En" = {
			"name" : "Key",
			"descricao" : "a mistyrious key"
		},
		"propriedades" ={
			"quantidade" : 0,
			"texture" : "res://sprites/itens/key-bluee.png"
		}
		}
	}
var equipaveis = {
	"Item_1" = {
		"pt" = {
			"name" : "Faca",
			"descricao" : "Um objeto de cozinha extremamaente cortante"
		},
		"En" = {
			"name" : "Knife",
			"descricao" : "A kitchen utensil extremely sharpnes"
		},
		"propriedades" ={
			"quantidade" : 1,
			"texture" : "res://sprites/itens/key-bluee.png"
		}
		}
}
