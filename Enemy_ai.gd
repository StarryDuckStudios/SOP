extends VBoxContainer


func enemy_atack():
	var acoes = []
	for child in $".".get_children():
		var agressividade = 0
		var porcentagem_vida = (100 * child.hp/child.max_hp)
		var lvl_dif = (child.lvl - InvGlobal.personagens.lvl)
		var heal_atk = []
		var def_atk = []
		var atk = []
		var acao
		# Classificar ataques em diferentes listas
		for ataque in child.ataques:
			if ataque.type == "heal":
				heal_atk.append(ataque)
			if ataque.type == 'def':
				def_atk.append(ataque)
			if ataque.type == 'atk':
				atk.append(ataque)
		# Calcular agressividade
		if lvl_dif != 0:
			agressividade += lvl_dif * 1
		# Escolher ação com base na agressividade
		if agressividade < -2:
			acao = escolhe_ataque(porcentagem_vida, agressividade, def_atk, heal_atk, atk, 0.5, 60)
		elif agressividade >= -2 and agressividade <= 2:
			acao = escolhe_ataque(porcentagem_vida, agressividade, def_atk, heal_atk, atk, 0.4, 50)
		else:
			acao = escolhe_ataque(porcentagem_vida, agressividade, def_atk, heal_atk, atk, 0.4, 35)
		
		acoes.append([escolhe_alvo(acao, child,acoes),child.name,acao.id])
	return acoes
func escolhe_ataque(porcentagem_vida, agressividade, def_atk, heal_atk, atk, tolerancia, tolerancia_vida):
	var prob_defesa = false
	var acao
	# Calcula a probabilidade de defesa
	if porcentagem_vida <= tolerancia_vida:
		prob_defesa = (randf() < (tolerancia + (agressividade * -0.05)))
	# Escolhe a ação com base na probabilidade de defesa
	if prob_defesa and (def_atk.size() > 0 or heal_atk.size() > 0):
		var choice = randf() < ( 0.5 + ((tolerancia_vida - porcentagem_vida)/100) )
		if choice:
			var random_index = randi_range(0, heal_atk.size() - 1)
			acao = heal_atk[random_index]
		else:
			var random_index = randi_range(0, def_atk.size() - 1)
			acao = def_atk[random_index]
	else:
		var random_index = randi_range(0, atk.size() - 1)
		acao = atk[random_index]
	return acao
func escolhe_alvo(acao, child, acoes):
	var lista_alvos_hp = []
	var lista_alvos_name = []
	var personagem = InvGlobal.personagens
	if acao.type == 'def' or acao.type == 'heal':
		return child.name
	for alvo in InvGlobal.personagens:
		if alvo != "lvl":
			var porcentagem_vida = (100 * personagem[alvo].hp/personagem[alvo].max_hp)
			if porcentagem_vida != 0:
				lista_alvos_hp.append(porcentagem_vida)
				lista_alvos_name.append(alvo)
	var target = selecionar_item_com_base_em_probabilidade(lista_alvos_name,calcular_probabilidades_inversas(lista_alvos_hp))
	var i = 0
	var j = 0
	for items in acoes:
		if target == items[0]:
			i += 1
		if i == 2:
			lista_alvos_hp.remove_at(j - 1)
			lista_alvos_name.remove_at(j - 1)
			target = selecionar_item_com_base_em_probabilidade(lista_alvos_name,calcular_probabilidades_inversas(lista_alvos_hp))
		j += 1
	return target
func calcular_probabilidades_inversas(valores):
	# Lista para armazenar os valores invertidos
	var inversos = []
	 # Variável para armazenar a soma total dos inversos
	var soma = 0.0
	# Itera sobre cada valor na lista
	for valor in valores:
		# Calcula o inverso do valor
		var inverso = 1.0 / valor
		 # Adiciona o inverso à lista de inversos
		inversos.append(inverso)
		# Adiciona o inverso à soma total
		soma += inverso
		# Lista para armazenar as probabilidades normalizadas
	var probabilidades = []
	# Itera sobre cada inverso na lista de inversos
	for inverso in inversos:
		 # Calcula a probabilidade normalizada
		var probabilidade = inverso / soma
		# Adiciona a probabilidade à lista de probabilidades
		probabilidades.append(probabilidade)
		 # Retorna a lista de probabilidades
	return probabilidades
func selecionar_item_com_base_em_probabilidade(itens, probabilidades):
	var rand = randf()
	var acumulado = 0.0
	for i in range(itens.size()):
		acumulado += probabilidades[i]
		if rand < acumulado:
			return itens[i]
