extends Node
var alvo
signal montagem_pronta
var inv_vazio = {
	"pt" : "Seu inventário está vázio!",
	"En" : "Your inventory is empty!"
}
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
			"preco" : 200,
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
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
		},
	"Item_3" = {
		"pt" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"En" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" ={
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
		},
	"Item_4" = {
		"pt" = {
			"name" : "Poção de mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"En" = {
			"name" : "Mana Potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" ={
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
		},
	"Item_5" = {
		"pt" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"En" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" ={
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
		},
	"Item_6" = {
		"pt" = {
			"name" : "Poção de mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"En" = {
			"name" : "Mana Potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" ={
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Antidote 1.png"
		}
		},
	"Item_7" = {
		"pt" = {
			"name" : "Poção de cura",
			"descricao" : "Uma poção capaz de regenerar sua vitalidade!"
		},
		"En" = {
			"name" : "Life potion",
			"descricao" : "A potions able to regen your vitality!"
		},
		"propriedades" ={
			"preco" : 200,
			"quantidade" : 5,
			"texture" : "res://sprites/itens/Health Potion 1.png"
		}
		},
	"Item_8" = {
		"pt" = {
			"name" : "Poção de mana",
			"descricao" : "Uma poção capaz de regenerar sua mana!"
		},
		"En" = {
			"name" : "Mana Potion",
			"descricao" : "A potions able to regen your mana!"
		},
		"propriedades" ={
			"preco" : 200,
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
# Called when the node enters the scene tree for the first time.
func cria_label():
	for child in get_node("Container/ItensPanel/Itens").get_children():
		child.free()
	for key in alvo.keys():
		if alvo[key]["propriedades"]["quantidade"] > 0:
			var item = alvo[key][ConfigsGlobais.language]["name"] + ": x" + str(alvo[key]["propriedades"]["quantidade"]) 
			var label = $"../Label".duplicate()
			label.name = key
			label.text = item
			print(label.name)
			get_node("Container/ItensPanel/Itens").add_child(label)
	if get_node("Container/ItensPanel/Itens").get_child_count() == 0:
		get_node("Descricao/TextureRect").texture = load("res://sprites/teia_sprite.jpg")
		get_node("Descricao/RichTextLabel").text = ""
		var label = $"../Label".duplicate()
		label.name = "erro"
		label.text = inv_vazio[ConfigsGlobais.language]
		get_node("Container/ItensPanel/Itens").add_child(label)
	else:
		monta_desc("Item_1")

func monta_inv(data):
	if data == "Consumiveis":
		alvo = consumiveis
	elif data == "ItensChave":
		alvo = itens_chave
	else:
		alvo = equipaveis
	cria_label()


func monta_desc(data):
	get_node("Descricao/TextureRect").texture = load(alvo[data]["propriedades"]["texture"])
	get_node("Descricao/RichTextLabel").text = alvo[data][ConfigsGlobais.language]["descricao"]
