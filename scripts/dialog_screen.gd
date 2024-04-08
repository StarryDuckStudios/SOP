extends Control
class_name DialogScreen
var control = 0
var primeira_vez = ChatsLog.npc_teste
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
	_initialize_dialog()

func _process(_delta):
	if Input.is_action_pressed("z") and _dialog.visible_ratio < 1:
		_step = 0.01
		return
	_step = 0.05
	if Input.is_action_just_pressed("z") and data[_id]["type"] == "fala":
		_id += 1
		if _id == data.size() - 1:
			ChatsLog.npc_teste = false
			configs._menu = true
			get_tree().paused = false
			queue_free()
			return
		if data[_id]["type"] == "resposta":
			var i: int = 0
			for child in get_node("Responder_Container/VContainer").get_children():
				child.text = data[_id]["dialog_" + str(i)][configs.language]
				i += 1 
		_initialize_dialog()
	
func _initialize_dialog():
	if primeira_vez:
		if data[_id]["type"] == "fala":
			get_node("BackGround").show()
			get_node("Responder_Container").hide()
			_name.text = data[_id]["title"]
			_dialog.text = data[_id][dialog][configs.language]
			_faceset.texture = load(data[_id]["faceset"])
			duplica_card()
		elif data[_id]["type"] == "resposta":
			get_node("Responder_Container").show()
			get_node("BackGround").hide()
	else:
		_id = data.size() - 2 #(1 resposta e 1 fala repetida)
		_name.text = data[100]["title"]
		_dialog.text = data[100][dialog][configs.language]
		_faceset.texture = load(data[100]["faceset"])
		
	_dialog.visible_characters = 0
	while _dialog.visible_ratio < 1:
		await get_tree().create_timer(_step).timeout
		_dialog.visible_characters += 1

#Parte de interação
func _input(event):
	if Input.is_action_just_pressed("x") and _dialog.visible_ratio == 1 and data[_id]["type"] == "fala":
		if get_node("ScrollContainer").is_visible_in_tree() == false:
			get_node("ScrollContainer").show()
			get_node("BackGround").hide()
		else:
			get_node("ScrollContainer").hide()
			get_node("BackGround").show()
	if data[_id]["type"] == "resposta":
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
func navegar(valor):
	control += valor
	get_node("Responder_Container/VContainer").get_child(control).get_child(0).show()
	get_node("Responder_Container/VContainer").get_child(control - valor).get_child(0).hide()
func duplica_card():
	var card = get_node("BackGround")
	var new_child = card.duplicate()
	new_child.show()
	get_node("ScrollContainer/ChatLog").add_child(new_child)
	print(new_child.get_child(0).get_child(1).get_child(1).text)
	#new_child.position = Vector2(0, _id * 155);
	new_child.custom_minimum_size.y = 150
	new_child.get_child(0).get_child(1).get_child(1).text = data[_id][dialog][configs.language];
