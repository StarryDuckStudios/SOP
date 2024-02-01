extends Node2D
signal change_character
func _input(event):
	if Input.is_action_just_pressed("1"):
		if $Personagem.name_ != "caleb":
			change_2("caleb")
	elif Input.is_action_just_pressed("2"):
		if $Personagem.name_ != "morgana":
			change_2("morgana")
	elif Input.is_action_just_pressed("3"):
		if $Personagem.name_ != "teste":
			change_2("teste")
	elif Input.is_action_just_pressed("4"):
		if $Personagem.name_ != "teste2":
			change_2("teste2")

func change_(seguidor):	
	var temp_txt
	var temp_name
	#name
	temp_name = seguidor.name_
	seguidor.name_ = $Personagem.name_
	$Personagem.name_ = temp_name
	#sprite
	temp_txt = seguidor.textura
	seguidor.textura = $Personagem.textura
	$Personagem.textura = temp_txt
	emit_signal("change_character")
	
func change_2(tag):
	if $Seguidor.name_ == tag:
		change_($Seguidor)
	elif $Seguidor2.name_ == tag:
		change_($Seguidor2)
	elif $Seguidor3.name_ == tag:
		change_($Seguidor3)
