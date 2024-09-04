extends Panel
var savecontrol = true 
@export var inventario = ""
func action():
	get_node("../../Inventario").monta_inv(inventario)
	get_node("../../Inventario").show()
	get_node("..").hide()
	ConfigsGlobais.caminho = "Inventario/Container/ItensPanel/Itens"
	ConfigsGlobais.caminho_volta.append("Mochila_Options")
	get_node("../..").atualiza_caminho("")
		
