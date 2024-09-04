extends HBoxContainer

func back():
	for child in get_node(".").get_children():
		await get_tree().create_timer(0.2).timeout
		child.show()
		
