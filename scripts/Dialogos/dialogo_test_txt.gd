extends Node
var txt: Dictionary = {
	"Item_1" = {
		"pt" = {
			"name" :  "Poção de Cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"En" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" = {
			"qtd" : 2,
			"preco" : 100,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
	},
	"Item_2" = {
		"pt" = {
			"name" :  "Poção de Mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"En" = {
			"name" : "Mana potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" = {
			"qtd" : 2,
			"preco" : 100,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
	}
}

var txtAgain: Dictionary = {
	0: {
		"faceset": "res://sprites/Caleb/Expressions/Caleb_Expression_3.png",
		"dialog_0" : {
			"pt": "Você denovo?",
			"En": "You again?",
			},
		"title" : "Calebo",
		"type" : "fala"
	}
}
var txtDiag: Dictionary = {
	"falas_aleatorias" ={
		"pt" = {
			1 : "*Seja bem vindo a minha loja!",
			2 : "*Muito bom te ver por aqui!",
			3 : "*Olá forasteiro deseja comprar algo?"
		},
		"En" = {
			1 : "*Welcome to my store!",
			2 : "*Very pleasead to see you here",
			3 : "*Hello foreigner, do you wish to see anything?"
		}
	}
}
