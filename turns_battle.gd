extends TextureRect
var ataques = []
var ataques_sort = []
var _atacante
var _spell
var _enemy
var _spell_id
func verifica_atacantes():
	var count = 0
	var array = []
	for child in $"../ActionBar/actionbarcontainer".get_children():
		if InvGlobal.personagens[child.name].hp > 0 and !child.atacou:
			count += 1
	if count == 0:
		var enemyy_atk = $"../Enemys".enemy_atack()
		for itens in enemyy_atk:
			ataques.append(itens)
		for itens in ataques:
			if itens[1] == 'caleb' or itens[1] == 'morgana' or itens[1] == 'darcy' or itens[1] == "dotty":
				print(InvGlobal.personagens[itens[1]].vel)
				array.append(InvGlobal.personagens[itens[1]].vel)
			else:
				for child in $"../Enemys".get_children():
					if itens[1] == child.name:
						array.append(child.vel)
		array.sort()
		#Ordena a lista
		var i = 0
		for items in array:
			for child in ataques:
				if child[1] == 'caleb' or child[1] == 'morgana' or child[1] == 'darcy' or child[1] == "dotty":
					if items == InvGlobal.personagens[child[1]].vel and child not in ataques_sort:
						ataques_sort.append(child)
						break
			for enemy in $"../Enemys".get_children():
				for obj in enemyy_atk:
					if items == enemy.vel and obj not in ataques_sort and enemy.name == obj[1]:
						ataques_sort.append(obj)
		print(ataques_sort)
