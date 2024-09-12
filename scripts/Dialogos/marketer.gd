extends Node
var original = InvGlobal.consumiveis
var txt: Dictionary = copia_dicionario(InvGlobal.consumiveis)

var txtDiag: Dictionary = {
		"falas_aleatorias" ={
		"pt" = {
			1 : "*Seja bem vindo a minha loja!",
			2 : "*Muito bom te ver por aqui!",
			3 : "*Olá forasteiro deseja comprar algo?"
		},
		"en" = {
			1 : "*Welcome to my store!",
			2 : "*Very pleasead to see you here",
			3 : "*Hello foreigner, do you wish to see anything?"
		}
	}
}
func copia_dicionario(d: Dictionary) -> Dictionary:
		var copia = {}
		for chave in d.keys():
			var valor = d[chave]
			if typeof(valor) == TYPE_DICTIONARY:
				copia[chave] = copia_dicionario(valor) # Recursivamente copiar dicionários
			elif typeof(valor) == TYPE_ARRAY:
				copia[chave] = valor.duplicate() # Copiar arrays
			else:
				copia[chave] = valor # Copiar outros tipos de valores
		return copia
