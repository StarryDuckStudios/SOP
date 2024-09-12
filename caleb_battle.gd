extends Panel
var savecontrol = true
@export var atacou = false
func action():
	if !atacou and InvGlobal.personagens[self.name].hp > 0:
		print(InvGlobal.personagens[self.name].hp)
		$"../..".control = 0
		$"../..".atualiza_caminho("","actionbarcontainer/" + self.name + "/Action/Actions")
		$Action/Actions/item.modulate = "Red"
		$"../..".caminho_volta.append("actionbarcontainer")
		$info.position.y = -50
		print("aa")
	else:
		self.modulate = "Red"
