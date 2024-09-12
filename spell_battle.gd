extends Panel
var savecontrol = true
func action():
	var background_script = $"../..//../../background"
	if InvGlobal.personagens[background_script._atacante].mana > InvGlobal.ataques[self.name].custo_mana:
		print(InvGlobal.ataques[self.name].custo_mana)
		var parent = get_parent().get_parent().get_parent()
		parent.atualiza_caminho("","../Enemys")
		$"../../../../background"._spell = self.name
		parent.caminho_volta.append("SpellContainer/spellbar")
		print("aa")
	else:
		self.modulate = "Red"
