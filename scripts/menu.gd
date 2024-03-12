extends Control
var menu = -1
var control = 0
var control_save = []
var caminho = "Menu_1"
var caminho_array = ["Menu_1"]
var positivo
var negativo
var permite = false
var voltar_ativado = true
var dicionario = {
	"/root/Menu/Modificar_Menu/Caleb" : card_volta,
	"/root/Menu/Modificar_Menu/Morgana" : card_volta,
	"/root/Menu/Modificar_Menu/Darcy" : card_volta,
	"/root/Menu/Modificar_Menu/Dotty" : card_volta,
}
func _ready():
	print(str($Modificar_Menu/Morgana.get_path()))
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
		if Input.is_action_just_pressed("x") and voltar_ativado:
			if caminho_array.size() > 1:
				permite = true
				verifica_volta()
				voltar()
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
	if get_node(caminho) == get_node("Modificar_Menu") and permite:
		for child in get_node("Modificar_Menu").get_children():
			if get_node(caminho).get_child(control).name == child.name:
				muda(str(child.get_path()))
				card_tween(str(child.get_path()), child.name)
		permite = false
	if get_node(caminho).get_child(control).name == "Equipar" or get_node(caminho).get_child(control).name == "Habilidades":
		muda("Modificar_Menu")
		permite = true

func muda(func_caminho):
	control_save.append(control)#Armazena o control para depois voltar ao mesmo lugar que estava
	caminho = func_caminho
	caminho_array.append(caminho)
	control = 0
	verifica()
func menus_options():
	equipar()
func verifica_volta():
	for caminhos_ in dicionario.keys():
		if caminhos_ == caminho:
			dicionario[caminhos_].call()
func voltar():
	get_node(caminho).get_child(control).modulate = "White"
	control = control_save[control_save.size() - 1] #Usa o backup do control para voltar a posição anterior
	control_save.pop_back()
	print(control_save)
	caminho_array.pop_back()
	caminho = caminho_array[caminho_array.size() -1]
	verifica()
func card_tween(caminho_, card):
	for child in get_node("Modificar_Menu").get_children():
		if child.name != card:
			child.hide()
		await get_tree().create_timer(0.1).timeout
	var tween = create_tween()
	voltar_ativado = false
	tween.tween_property(get_node(caminho_), "position", Vector2(0, 0), 0.5)
	tween.connect("finished", func voltar(): voltar_ativado = true)
	await get_tree().create_timer(0).timeout 
func card_volta():
	for child in get_node("Modificar_Menu").get_children():
		child.show()
		await get_tree().create_timer(0.1).timeout
		

	
