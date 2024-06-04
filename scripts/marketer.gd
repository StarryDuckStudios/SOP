extends Control
var control = 0
var config = ConfigsGlobais
@onready var _dialog = get_node("Container/Dialogo/RichTextLabel")
@onready var menu_options = get_node(caminho)
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
var dialogo_dicionario = {
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

func _ready():
	$AnimationPlayer.play("aparece")
	$Container/Dialogo/RichTextLabel.text = dialogo_dicionario["falas_aleatorias"][language][int(randf_range(1,4))]
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
		monta_item(Inventario.consumiveis)

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		if control < get_node(caminho).get_child_count(control) - 1:
			navegar(+1)
	if Input.is_action_just_pressed("ui_up"):
		if control > 0:
			navegar(-1)
	if Input.is_action_just_pressed("z"):
		if menu_options.get_child(control).name  == "Sair":
			sair()
		if menu_options.get_child(control).name  == "Comprar" and caminho == "Container/Options/VBoxContainer":
			operacao = "compra"
			comprar(data)
		if menu_options.get_child(control).name  == "Vender" and caminho == "Container/Options/VBoxContainer":
			operacao = "venda"
			comprar(Inventario.consumiveis)
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
		label.text = data_[key][language]["name"]+ ": $"+str(data_[key]["propriedades"]["preco"]) 
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
		get_node(caminho).get_child(control).modulate = "White"
		caminho_array.pop_back()
		caminho = caminho_array[caminho_array.size() -1]
		print(caminho_array)
func monta_item(data_):
	get_node(caminho).get_child(control).modulate = "Red"
	get_node("Container/Loja/TextureRect").texture = load(data_[get_node(caminho).get_child(control).name]["propriedades"]["texture"])
	get_node("Container/Loja/RichTextLabel").text = data_[get_node(caminho).get_child(control).name][language]["descricao"]
