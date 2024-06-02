extends Control
var control = 0
var config = ConfigsGlobais
@onready var _dialog = get_node("Container/Dialogo/RichTextLabel")
@onready var menu_options = get_node(caminho)
var _step: float = 0.05
var language = ConfigsGlobais.language
var caminho = "Container/Options/VBoxContainer"
var data: Dictionary = {
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

func _ready():
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
		if menu_options.get_child(control).name  == "Comprar":
			comprar()
func sair():
	config._menu = true
	get_tree().paused = false
	queue_free()
func dialogo():
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1
func comprar():
	get_node("Container/Options/VBoxContainer").hide()
	get_node("Container/Dialogo").hide()
	get_node("Container/Loja").show()
	for key in data.keys():
		var label = get_node("Label").duplicate()
		label.show()
		label.text = data[key][language]+ ": $"+str(data[key]["preco"]) 
		get_node("Container/Loja/ScrollContainer/VBoxContainer").add_child(label)
func criaLabel():
	print()
