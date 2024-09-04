extends Timer
var tempo: int = 0

func _on_timeout():
	tempo += 1
	print(tempo)
