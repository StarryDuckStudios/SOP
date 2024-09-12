extends Panel
var savecontrol = true
func action():
	var _name = get_parent().get_parent().get_parent().name
	var parent = $"../../../../.."
	var data = InvGlobal.personagens[_name]['move']
	parent.control = 0
	parent.atualiza_caminho("","SpellContainer/spellbar")
	$"../../../../../SpellContainer".show()
	parent.caminho_volta.append("actionbarcontainer/" + _name + "/Action/Actions")
	$"../../../..".position.y = -50
	for child in $"../../../../../SpellContainer/spellbar".get_children():
		child.free()
	for items in data:
		var _new = $"../../../../../../spell".duplicate()
		if data[items] != null:
			_new.name = data[items].id
			$"../../../../../../background"._atacante = _name
			_new.get_node("name").text = data[items].name
			_new.get_node("mana").text = "Mana: " + str(data[items].custo_mana)
			_new.get_node("atk").text = "Ataque base: " + str(data[items].dmg.base)
			_new.get_node("acc").text = "Precisão: " + str(data[items].acc*100)
			$"../../../../../SpellContainer/spellbar".add_child(_new)
	$"../../../../../SpellContainer/spellbar".get_child(0).modulate = "Red"
	print("aa")
