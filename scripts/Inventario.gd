extends Node
var alvo
var inv_vazio = {
	"pt" : "Seu inventário está vázio!",
	"en" : "Your inventory is empty!"
}
var consumiveis : Dictionary 
var itens_chave  : Dictionary 
var equipaveis  : Dictionary 
# Called when the node enters the scene tree for the first time.
func _input(event):
	consumiveis = InvGlobal.consumiveis
	itens_chave = InvGlobal.itens_chave
	equipaveis = InvGlobal.equipaveis
	if Input.is_action_just_pressed("ui_accept"):
		print(consumiveis)
func cria_label():
	for child in get_node("Container/ItensPanel/Itens").get_children():
		child.free()
	for key in alvo.keys():
		if alvo[key]["propriedades"]["quantidade"] > 0:
			var item = alvo[key][ConfigsGlobais.language]["name"] + ": x" + str(alvo[key]["propriedades"]["quantidade"]) 
			var label = $"../Label".duplicate()
			label.name = key
			label.text = item
			print(label.name)
			get_node("Container/ItensPanel/Itens").add_child(label)
	if get_node("Container/ItensPanel/Itens").get_child_count() == 0:
		get_node("Descricao/TextureRect").texture = load("res://sprites/teia_sprite.jpg")
		get_node("Descricao/RichTextLabel").text = ""
		var label = $"../Label".duplicate()
		label.name = "erro"
		label.text = inv_vazio[ConfigsGlobais.language]
		get_node("Container/ItensPanel/Itens").add_child(label)
	else:
		monta_desc("Item_1")

func monta_inv(data):
	if data == "Consumiveis":
		consumiveis = InvGlobal.consumiveis
		alvo = consumiveis
	elif data == "ItensChave":
		itens_chave = InvGlobal.itens_chave
		alvo = itens_chave
	else:
		equipaveis = InvGlobal.equipaveis
		alvo = equipaveis
	cria_label()


func monta_desc(data):
	get_node("Descricao/TextureRect").texture = load(alvo[data]["propriedades"]["texture"])
	get_node("Descricao/RichTextLabel").text = alvo[data][ConfigsGlobais.language]["descricao"]
func retiraItem(caminho, qtd):
	consumiveis[caminho].propriedades.quantidade -= qtd
