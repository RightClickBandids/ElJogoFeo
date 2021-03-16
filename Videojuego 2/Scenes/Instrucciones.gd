extends CanvasLayer







func _on_Atras_pressed():
	get_tree().change_scene("res://Scenes/EscenaInicial.tscn")


func _on_BEmpezar_pressed():
	get_tree().change_scene("res://Scenes/EscenaJuego.tscn")


func _on_BSalir_pressed():
	get_tree().quit()
