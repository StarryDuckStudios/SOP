extends Control
var control = 0
var invVazio = false
var loopOn = false
var config = ConfigsGlobais
@onready var _dialog = get_node("Container/Dialogo/RichTextLabel")
@onready var dinheiro = get_node("Container/Options/Label")
var _step: float = 0.05
var operacao
var language = ConfigsGlobais.language
var caminho = "Container/Options/VBoxContainer"
var caminho_array = ["Container/Options/VBoxContainer"]
var data: Dictionary = {
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
var dialogo_dicionario: Dictionary = {

}

func _ready():
	dinheiro.text = str(InvGlobal.dinheiro) + "$"
	$AnimationPlayer.play("aparece")
	$Container/Dialogo/RichTextLabel.text = dialogo_dicionario["falas_aleatorias"][language][int(randf_range(1,3.99))]
	dialogo()
	get_node(caminho).get_child(control).modulate = "Red"
	#get_tree().paused = true
	config._menu = false
	seta_lingua()
func seta_lingua():
	var language 
	if config.language == "pt":
		language = 0
	else:
		language = 1
	for child in get_node(caminho).get_children():
		for granChild in child.get_children():
			granChild.hide()
		child.get_child(language).show()
func navegar(valor):
	control += valor
	get_node(caminho).get_child(control).modulate = "Red"
	get_node(caminho).get_child(control - valor).modulate = "White"
	if caminho == "Container/Loja/ScrollContainer/VBoxContainer" and operacao == "compra":
		get_node("Container/Loja/ScrollContainer").scroll_vertical += valor * 20
		monta_item(data)
	if caminho == "Container/Loja/ScrollContainer/VBoxContainer" and operacao == "venda":
		get_node("Container/Loja/ScrollContainer").scroll_vertical += valor * 20
		monta_item(InvGlobal.consumiveis)
		print(get_node(caminho).get_child(control).name)

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		if control < get_node(caminho).get_child_count(control) - 1:
			navegar(+1)
	if Input.is_action_just_pressed("ui_up"):
		if control > 0:
			navegar(-1)
	if Input.is_action_just_pressed("z"):
		if get_node(caminho).get_child(control).name  == "Sair" and caminho == "Container/Options/VBoxContainer":
			sair()
		elif get_node(caminho).get_child(control).name  == "Comprar" and caminho == "Container/Options/VBoxContainer":
			operacao = "compra"
			comprar(data)
		elif get_node(caminho).get_child(control).name  == "Vender" and caminho == "Container/Options/VBoxContainer":
			operacao = "venda"
			comprar(InvGlobal.consumiveis)
		elif "Item_" in get_node(caminho).get_child(control).name and operacao == "compra":
			var inv = InvGlobal.consumiveis
			var key = get_node(caminho).get_child(control).name
			if InvGlobal.dinheiro >= data[key]["propriedades"]["preco"] and loopOn == false:
				var armazena_dinheiro = InvGlobal.dinheiro
				InvGlobal.dinheiro -= max(0, data[key]["propriedades"]["preco"])
				while armazena_dinheiro > InvGlobal.dinheiro:
					loopOn = true
					dinheiro.text = str(armazena_dinheiro - 1)+ "$"
					armazena_dinheiro -= 1
					await get_tree().create_timer(0.01).timeout
				loopOn = false
				inv[key]["propriedades"]["quantidade"] += 1
			print(inv[key]["propriedades"]["quantidade"])
		elif "Item_" in get_node(caminho).get_child(control).name and operacao == "venda":
			var inv = InvGlobal.consumiveis
			var key = get_node(caminho).get_child(control).name
			if inv[key]["propriedades"]["quantidade"] > 0:
				var armazena_dinheiro = InvGlobal.dinheiro
				inv[key]["propriedades"]["quantidade"] = max(0, inv[key]["propriedades"]["quantidade"] - 1)
				InvGlobal.dinheiro += inv[key]["propriedades"]["preco"]
				get_node(caminho).get_child(control).text =  inv[key][language]["name"] + " x" + str(inv[key]["propriedades"]["quantidade"])+ ": $"+str(inv[key]["propriedades"]["preco"])
				while armazena_dinheiro < InvGlobal.dinheiro:
					loopOn = true
					dinheiro.text = str(armazena_dinheiro + 1)+ "$"
					armazena_dinheiro += 1
					await get_tree().create_timer(0.01).timeout
				loopOn = false
			print(inv[key]["propriedades"]["quantidade"])
	if Input.is_action_just_pressed("x"):
		voltar()
func sair():
	config._menu = true
	get_tree().paused = false
	queue_free()
func dialogo():
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
func comprar(data_):
	get_node("Container/Loja/ScrollContainer").scroll_vertical = 0
	get_node("Container/Options/VBoxContainer").hide()
	get_node("Container/Dialogo").hide()
	get_node("Container/Loja").show()
	criaLabel(data_)
	caminho = "Container/Loja/ScrollContainer/VBoxContainer"
	caminho_array.append(caminho)
	control = 0
	monta_item(data_)
func criaLabel(data_):
	for child in get_node("Container/Loja/ScrollContainer/VBoxContainer").get_children():
		child.free()
	for key in data_.keys():
		var label = get_node("Label").duplicate()
		label.show()
		label.name = key
		if operacao == "compra":
			label.text = data_[key][language]["name"]+ ": $"+str(data_[key]["propriedades"]["preco"])
		else:
			label.text = data_[key][language]["name"] + " x" + str(data_[key]["propriedades"]["quantidade"])+ ": $"+str(data_[key]["propriedades"]["preco"])
		if operacao == "venda" and data_[key]["propriedades"]["quantidade"] > 0:
			get_node("Container/Loja/ScrollContainer/VBoxContainer").add_child(label)
		elif operacao == "compra":
			get_node("Container/Loja/ScrollContainer/VBoxContainer").add_child(label)
	if get_node("Container/Loja/ScrollContainer/VBoxContainer").get_child_count() == 0:
		var label = get_node("Label").duplicate()
		invVazio = true
		label.show()
		label.name =  Inventario.inv_vazio[language]
		label.text = "Nenhum item disponível para venda!"
		get_node("Container/Loja/ScrollContainer/VBoxContainer").add_child(label)
func voltar():
	if caminho == "Container/Loja/ScrollContainer/VBoxContainer":
		get_node("Container/Options/VBoxContainer").show()
		get_node("Container/Dialogo").show()
		get_node("Container/Loja").hide()
	if caminho_array.size() > 1:
		if operacao == "compra":
			control = 0
		else:
			control = 1
		caminho_array.pop_back()
		caminho = caminho_array[caminho_array.size() -1]
		print(caminho_array)
func monta_item(data_):
	get_node(caminho).get_child(control).modulate = "Red"
	if invVazio == false:
		get_node("Container/Loja/TextureRect").texture = load(data_[get_node(caminho).get_child(control).name]["propriedades"]["texture"])
		get_node("Container/Loja/RichTextLabel").text = data_[get_node(caminho).get_child(control).name][language]["descricao"]
	else:
		invVazio = false
		get_node("Container/Loja/TextureRect").texture = load("res://sprites/teia_sprite.jpg")
		get_node("Container/Loja/RichTextLabel").text = ""
