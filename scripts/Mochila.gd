extends Panel
var savecontrol = true
func hover():
	var node = "../../../Mochila_Options"
	if !get_node(node).is_visible():
		get_node(node).show()
	else:
		get_node(node).hide()
func action():
	ConfigsGlobais.caminho = "Mochila_Options"
	ConfigsGlobais.caminho_volta.append("ContainerMenu_1/Menu_1")
	get_node("../../..").atualiza_caminho("") #Atualiza o caminho

