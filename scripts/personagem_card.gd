extends Panel
var savecontrol = true
@export var name_personagem = ""
func action():
	ConfigsGlobais.caminho = "Modificar_Menu/" + name_personagem
	ConfigsGlobais.caminho_volta.append("Modificar_Menu")
	get_node("../..").atualiza_caminho("") #Atualiza o caminho
	card_tween()
func card_tween():
	for child in get_node("..").get_children():
		if child.name != name_personagem:
			child.hide()
			await get_tree().create_timer(0.1).timeout
	var tween = create_tween()
	tween.tween_property(get_node("."), "position", Vector2(0, 0), 0.5)
	await get_tree().create_timer(0).timeout 
