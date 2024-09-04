extends Panel
var savecontrol = true
func hover():
	var node = "../../../Modificar_Menu"
	if !get_node(node).is_visible():
		get_node(node).show()
		get_node("../../../Money").show()
	else:
		get_node(node).hide()
		get_node("../../../Money").hide()
func action():
	ConfigsGlobais.caminho = "Modificar_Menu"
	ConfigsGlobais.caminho_volta.append("ContainerMenu_1/Menu_1")
	get_node("../../..").atualiza_caminho("") #Atualiza o caminho
