extends Control
var menu = -1
var control = 0
var control_save = []
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
			modificar_action()
		if Input.is_action_just_pressed("x"):
			if caminho_array.size() > 1:
				get_node(caminho).get_child(control).modulate = "White"
				control = control_save[control_save.size() - 1] #Usa o backup do control para voltar a posição anterior
				control_save.pop_back()
				print(control_save)
				caminho_array.pop_back()
				caminho = caminho_array[caminho_array.size() -1]
				verifica()
			else:
				menu *= -1
	else:
		$".".hide()
		get_node(caminho).get_child(control).modulate = "White"
		control = 0 #Zera o control pois estamos saindo do menu
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
	if get_node(caminho).get_child_count() > 1:
		control += valor
		get_node(caminho).get_child(control).modulate = "Red"
		get_node(caminho).get_child(control - valor).modulate = "White"
	
#Menu Options
func equipar():
	print()
func modificar_action():
	if get_node(caminho).get_child(control).name == "Equipar" or get_node(caminho).get_child(control).name == "Habilidades":
		muda("Modificar_Menu")
func muda(func_caminho):
	control_save.append(control)#Armazena o control para depois voltar ao mesmo lugar que estava
	caminho = func_caminho
	caminho_array.append(caminho)
	control = 0
	verifica()
func menus_options():
	equipar()
