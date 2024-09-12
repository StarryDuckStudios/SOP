extends Panel
@onready var caminho = "actionbarcontainer"
var caminho_volta = []
var control = 0
var save_control = []
##Input
var positivo = "ui_right"
var negativo = "ui_left"
func _ready():
	verifica()
func _input(event):
	if Input.is_action_just_pressed(positivo) and control < get_node(caminho).get_child_count() - 1:
		navegar(+1)
	elif Input.is_action_just_pressed(negativo) and (control - 1 >= 0):
		navegar(-1)
	elif Input.is_action_just_pressed("z"):
		if get_node(caminho).get_child(control).savecontrol:
			save_control.append(control)
		if get_node(caminho).get_child(control).has_method("action"):
			get_node(caminho).get_child(control).modulate = "White"
			get_node(caminho).get_child(control).action()		
			verifica()
	elif Input.is_action_just_pressed("x"):
		if save_control.size() >0:
			atualiza_caminho("volta","")
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
func atualiza_caminho(verifica, caminho_):
	if verifica == "volta": #Se o verifica é igual a volta ele usa o caminho_volta
		get_node(caminho).get_child(control).modulate = "White"
		control = save_control.pop_back()
		if get_node(caminho).has_method("back"):
			get_node(caminho).back()
		caminho = caminho_volta.pop_back()
		get_node(caminho).get_child(control).modulate = "Red"
	else: #Se não, a função é usada para atualizar o próximo caminho
		caminho = caminho_
	verifica()
