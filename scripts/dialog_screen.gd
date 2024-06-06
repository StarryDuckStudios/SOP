extends Control
class_name DialogScreen
var control = 0
var chatlog_on = false
var npc_alvo = ChatsLog.chat_ativo; #Uma varíável global atribui a chave do chat ativo para ser usada dinamicamente
var primeira_vez = ChatsLog[npc_alvo].primeira_vez;
var dialog = "dialog_0"
var _step: float = 0.05 #Velocidade do texto

var _id: int = 0 #Usado para acessar o índice do diálogo
var configs = ConfigsGlobais
var data: Dictionary = {
}
@export_category("Objects")
@export var _name: Label = null
@export var _dialog: RichTextLabel = null
@export var _faceset: TextureRect = null

func _ready():
	get_node("Responder_Container").hide()
	get_node("ScrollContainer").hide()
	get_tree().paused = true
	configs._menu = false
	if primeira_vez == false:
		for cards in ChatsLog[npc_alvo].chat_log.values():
			var card_duplicate = cards.duplicate()
			get_node("ScrollContainer/ChatLog").add_child(card_duplicate)
	_initialize_dialog()
func _process(_delta):
	if chatlog_on:
		navega_chat_log()
	if Input.is_action_pressed("z") and _dialog.visible_ratio < 1:
		_step = 0.01
		return
	_step = 0.05
	if Input.is_action_just_pressed("z") and data[_id]["type"] == "fala" and chatlog_on == false:
		_id += 1
		if _id == data.size():
			encerra()
			return
		elif data[_id]["type"] == "resposta":
			cria_containers()
		_initialize_dialog()
	
func _initialize_dialog():
	if data[_id][dialog][configs.language] == "":
		encerra()
		return
	else:
		if data[_id]["type"] == "fala":
			get_node("BackGround").show()
			get_node("Responder_Container").hide()
			_name.text = data[_id]["title"]
			_dialog.text = data[_id][dialog][configs.language]
			_faceset.texture = load(data[_id]["faceset"])
			duplica_card(data[_id][dialog][configs.language])
		elif data[_id]["type"] == "resposta":
			get_node("Responder_Container").show()
			get_node("BackGround").hide()
			
		_dialog.visible_characters = 0
		while _dialog.visible_ratio < 1:
			await get_tree().create_timer(_step).timeout
			_dialog.visible_characters += 1
#Parte de interação
func _input(event):
	if data[_id]["type"] == "resposta" and chatlog_on == false:
		if Input.is_action_just_pressed("ui_down"):
			if control < get_node("Responder_Container/VContainer").get_child_count(control) - 1:
				navegar(+1)
		if Input.is_action_just_pressed("ui_up"):
			if control > 0:
				navegar(-1)
		if Input.is_action_just_pressed("z"):
			for child in get_node("Responder_Container/VContainer").get_children():
				if get_node("Responder_Container/VContainer").get_child(control).name == child.name:
					data[_id]["type"] = "fala"
					dialog = "dialog_" + str(control)
					control = 0
					_initialize_dialog()
	if Input.is_action_just_pressed("x") and _dialog.visible_ratio == 1:
		get_node("ScrollContainer").scroll_vertical +=1000
		if get_node("ScrollContainer").is_visible_in_tree() == false:
			chatlog_on = true
			get_node("ScrollContainer").show()
			get_node("BackGround").hide()
		else:
			chatlog_on = false
			get_node("ScrollContainer").hide()
			if data[_id]["type"] == "fala": #Caso esteja no campo de resposta, não exibira o quadro de fala
				get_node("BackGround").show()
			
func navegar(valor):
	control += valor
	get_node("Responder_Container/VContainer").get_child(control).get_child(0).show()
	get_node("Responder_Container/VContainer").get_child(control - valor).get_child(0).hide()
func duplica_card(texto):
	var card = get_node("BackGround")
	var new_child = card.duplicate()
	new_child.show()
	new_child.get_child(0).get_child(1).get_child(1).visible_ratio = 1
	new_child.get_child(0).get_child(1).get_child(1).text = texto;
	new_child.custom_minimum_size.y = 150
	get_node("ScrollContainer/ChatLog").add_child(new_child)
	var chatlog_card = new_child.duplicate()
	if primeira_vez:
		ChatsLog[npc_alvo]["chat_log"][_id] = chatlog_card
	print(ChatsLog[npc_alvo].chat_log)
func navega_chat_log():
		if Input.is_action_pressed("ui_up"):
			get_node("ScrollContainer").scroll_vertical -= 10
		elif Input.is_action_pressed("ui_down"):
			get_node("ScrollContainer").scroll_vertical += 10
		elif Input.is_action_just_pressed("ui_right"):
			var tween = create_tween()
			tween.tween_property(get_node("ScrollContainer"), "scroll_vertical", get_node("ScrollContainer").get_v_scroll_bar( ).max_value, 0.5)
		elif Input.is_action_just_pressed("ui_left"):
			var tween = create_tween()
			tween.tween_property(get_node("ScrollContainer"), "scroll_vertical", get_node("ScrollContainer").get_v_scroll_bar( ).min_value, 0.5)
func cria_containers():
	var i: int = 0
	for child in data[_id]:
		if "dialog" in child:
			var new_dialog = get_node("Opcao_1").duplicate()
			new_dialog.show()
			if child != "dialog_0":
				new_dialog.get_child(0).hide()
			get_node("Responder_Container/VContainer").add_child(new_dialog)
		get_node("Responder_Container/VContainer").get_child_count()
	for child in get_node("Responder_Container/VContainer").get_children():
		child.custom_minimum_size.y = 132/get_node("Responder_Container/VContainer").get_child_count()
		child.text = data[_id]["dialog_" + str(i)][configs.language]
		i += 1 
func encerra():			
	ChatsLog[npc_alvo].primeira_vez = false
	configs._menu = true
	get_tree().paused = false
	queue_free()
