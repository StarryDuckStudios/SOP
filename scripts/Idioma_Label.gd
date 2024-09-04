extends Panel
var savecontrol = false
func action():
	var languages = ["pt", "en"]
	var tamanho = languages.size()
	var index = languages.find(ConfigsGlobais.language)
	if index + 1 < tamanho:
		ConfigsGlobais.language = languages[index + 1]
	else:
		ConfigsGlobais.language = languages[0]
	get_node("../../..").seta_lingua()
