extends Node
var config = ConfigsGlobais
var control = 0
var save_control = []
var caminho
##Input
var positivo = "ui_right"
var negativo = "ui_left"
func _process(delta):
	pass
func atualiza_caminho(verifica):
	if verifica == "volta": #Se o verifica é igual a volta ele usa o caminho_volta
		get_node(caminho).get_child(control).modulate = "White"
		control = save_control.pop_back()
		caminho = ConfigsGlobais.caminho_volta.pop_back()
		if get_node(caminho).has_method("back"):
			get_node(caminho).back()
	else: #Se não, a função é usada para atualizar o próximo caminho
		caminho = ConfigsGlobais.caminho
	verifica()
func _ready():
	$Money/Label.text = str(InvGlobal.dinheiro) + "$" 
	get_tree().paused = true
	seta_lingua()
	ConfigsGlobais.caminho = "ContainerMenu_1/Menu_1"
	atualiza_caminho("")
	get_node(caminho).get_child(control).modulate = "Red"
func seta_lingua():
	var language 
	if config.language == "pt":
		language = 0
	else:
		language = 1
	for child in get_node("Mochila_Options").get_children():
		for granChild in child.get_children():
			granChild.hide()
		child.get_child(language).show()
	for child in get_node("ContainerMenu_1/Menu_1").get_children():
		for granChild in child.get_children():
			granChild.hide()
		child.get_child(language).show()
	for child in get_node("Options/opcoes_box").get_children():
		for granChild in child.get_children():
			granChild.hide()
		child.get_child(language).show()
func _input(event):
	if Input.is_action_just_pressed(positivo) and control < get_node(caminho).get_child_count() - 1:
		navegar(+1)
	elif Input.is_action_just_pressed(negativo) and (control - 1 >= 0):
		navegar(-1)
	elif Input.is_action_just_pressed("z"):
		if get_node(caminho).get_child(control).savecontrol:
			save_control.append(control)
		if get_node(caminho).get_child(control).has_method("action"):
			get_node(caminho).get_child(control).action()
			verifica()
		get_node(caminho).get_child(0).modulate = "Red"
		control = 0 
	elif Input.is_action_just_pressed("x"):
		if ConfigsGlobais.caminho_volta.size() == 0:
			queue_free()
			get_tree().paused = false
		else:
			atualiza_caminho("volta")
func verifica():
	if get_node(caminho) is HBoxContainer:
		positivo = "ui_right"
		negativo = "ui_left"
	elif  get_node(caminho) is VBoxContainer:
		positivo = "ui_down"
		negativo = "ui_up"
func navegar(valor):
	control += valor
	if get_node(caminho).get_child_count() > 1:
		get_node(caminho).get_child(control).modulate = "Red"
		get_node(caminho).get_child(control - valor).modulate = "White"
		if get_node(caminho).get_child(control).has_method("hover"):
			get_node(caminho).get_child(control - valor).hover()
			get_node(caminho).get_child(control).hover()
		if caminho == "Inventario/Container/ItensPanel/Itens":
			get_node("Inventario").monta_desc(get_node(caminho).get_child(control).name)
	
