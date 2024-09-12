extends Node
var dinheiro = 0
var consumiveis = {
	"Item_1" = {
		"pt" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"en" = {
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
		"en" = {
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
var ataques = {
	'fireball': {
		"name": "Bola de Fogo",
		'type': "atk",
		"dmg": {
			'base': 120,
			'divisor': 40
		},
		"effect" : {
			'name' : 'burning',
			'prob' : 0.1,
			'dmg' : 5,
			'turnos' : {
				'start' : 1,
				'end' : 4,
			}
		},
		"acc": 0.85,
		"custo_mana": 40,
		'id' : 'fireball',
	},
	'shield': {
		"name": "Escudo Mágico",
		'type': "def",
		"dmg": null,
		"effect": {
			'name': null,
			'prob': null,
			'dmg': null,
			'turnos': {
				'start': 1,
				'end': 3,
			}
		},
		"acc": 1,
		"custo_mana": 30,
		'id': 'shield',
		"defense_increase": 20  # Aumenta a defesa em 20 pontos
	},
	'heal': {
		"name": "Cura Rápida",
		'type': "heal",
		"dmg": null,
		"effect": null,
		"acc": 1,
		"custo_mana": 30,
		'id': 'heal',
		"heal_amount": 100  # Cura 100 pontos de vida
	},
	'ice_ray': {
		"name": "Raio de Gelo",
		'type': "atk",
		"dmg": {
			'base': 80,
			'divisor': 30
		},
		"effect" : {
			'name' : 'frozen',
			'prob' : 0.2,
			'dmg' : 3,
			'turnos' : {
				'start' : 1,
				'end' : 3,
			}
		},
		"acc": 0.75,
		"custo_mana": 35,
		'id' : 'ice_ray',
	}
}

var personagens = {
	'lvl' = 1,
	'caleb' = {
		'max_hp' : 120,
		'hp' : 100,
		'atk' : 30,
		'def' : 20,
		'vel' : 10.1,
		'max_mana' : 250,
		'mana' : 200,
		'move' : {
			'move1' : ataques['fireball'],
			'move2' : null,
			'move3' : null,
			'move4' : null,
		}
	},
	'morgana' = {
		'max_hp' : 120,
		'hp' : 20,
		'atk' : 30,
		'def' : 10,
		'vel' : 20,
		'max_mana' : 250,
		'mana' : 200,
		'move' : {
			'move1' : ataques['fireball'],
			'move2' : null,
			'move3' : null,
			'move4' : null,
		}
	},
	'darcy' = {
		'max_hp' : 120,
		'hp' : 0,
		'atk' : 30,
		'def' : 10,
		'vel' : 20,
		'max_mana' : 250,
		'mana' : 200,
		'move' : {
			'move1' : null,
			'move2' : null,
			'move3' : null,
			'move4' : null,
		}
	},
	'dotty' = {
		'max_hp' : 120,
		'hp' : 0,
		'atk' : 30,
		'def' : 10,
		'vel' : 10.1,
		'max_mana' : 250,
		'mana' : 200,
		'move' : {
			'move1' : ataques['fireball'],
			'move2' : null,
			'move3' : null,
			'move4' : null,
		}
	}
}

