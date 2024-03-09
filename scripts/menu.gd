extends Control
var menu = -1
var control = 0
var control_save = 0
var caminho = "Menu_1"
var caminho_array = ["Menu_1"]
var positivo
var negativo
func _ready():
	$".".hide()
	verifica()
func _input(event):
	if Input.is_action_just_pressed("x") and menu == -1:
		await get_tree().create_timer(0.1).timeout 
		menu *= -1
	if menu == 1:
		$".".show()
		if Input.is_action_just_pressed(positivo):
			if control < get_node(caminho).get_child_count(control) - 1:
				navegar(+1)
				menus_options()
		if Input.is_action_just_pressed(negativo):
			if control > 0:
				navegar(-1)
				menus_options()
		if Input.is_action_just_pressed("z"):
			await get_tree().create_timer(0.1).timeout 
			modificar_action()
		if Input.is_action_just_pressed("x"):
			get_node(caminho).get_child(control).modulate = "White"
			if caminho_array.size() > 1:
				control = control_save #Usa o backup do control para voltar a posição anterior
				caminho_array.pop_back()
				caminho = caminho_array[caminho_array.size() -1]
				verifica()
			else:
				control = 0 #Zera o control pois estamos saindo do menu
				menu *= -1
	else:
		$".".hide()
		get_node(caminho).get_child(control).modulate = "White"
		verifica()
func verifica():
	get_node(caminho).get_child(control).modulate = "Red"
	if get_node(caminho) is HBoxContainer:
		positivo = "ui_right"
		negativo = "ui_left"
	elif  get_node(caminho) is VBoxContainer:
		positivo = "ui_down"
		negativo = "ui_up"
		
func navegar(valor):
	control += valor
	get_node(caminho).get_child(control).modulate = "Red"
	get_node(caminho).get_child(control - valor).modulate = "White"
	
#Menu Options
func equipar():
	if get_node(caminho).get_child(control).name == "Equipar":
		$Layout_Maior/Equipar_Panel.hide()
	else:
		$Layout_Maior/Equipar_Panel.hide()
		
func modificar_action():
	control_save = control #Armazena o control para depois voltar ao mesmo lugar que estava
	if get_node(caminho).get_child(control).name == "Equipar" or get_node(caminho).get_child(control).name == "Habilidades":
		caminho = "Modificar_Menu"
		caminho_array.append(caminho)
		verifica()
		
func menus_options():
	equipar()
