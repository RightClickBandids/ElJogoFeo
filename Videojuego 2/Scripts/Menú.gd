extends CanvasLayer



func _on_BInstruciones_pressed():
	#entrar al arbol de nodos
	get_tree().change_scene("res://inicio/Controlinstrucciones.tscn")

func _on_BEmpezar_pressed():
	get_tree().change_scene("res://EscenaJuego.tscn")


func _on_BSalir_pressed():
	get_tree().quit()
