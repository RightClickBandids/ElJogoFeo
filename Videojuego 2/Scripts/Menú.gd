extends CanvasLayer



func _on_BInstruciones_pressed():
	#entrar al arbol de nodos
	get_tree().change_scene("res://Scenes/Instrucciones.tscn")

func _on_BEmpezar_pressed():
	get_tree().change_scene("res://Scenes/EscenaJuego.tscn")


func _on_BSalir_pressed():
	get_tree().quit()


func _on_VideoPlayer_finished():
	get_tree().change_scene("res://Scenes/Instrucciones.tscn")
