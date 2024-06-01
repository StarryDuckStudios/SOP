extends Node
var alvo
signal montagem_pronta
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
			"quantidade" : 1,
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
		var item = alvo[key][ConfigsGlobais.language]["name"] + ": x" + str(alvo[key]["propriedades"]["quantidade"]) 
		var label = $"../Label".duplicate()
		label.name = key
		label.text = item
		print(label.name)
		get_node("Container/ItensPanel/Itens").add_child(label)
	monta_desc("Item_1")
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



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
