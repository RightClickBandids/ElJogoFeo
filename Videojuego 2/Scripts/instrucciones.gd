extends CanvasLayer



func _on_Juego_pressed():
	 get_tree().change_scene("res://EscenaJuego.tscn")


func _on_Regresar__pressed():
	get_tree().change_scene("res://inicio/Menú.tscn")


func _on_SalirJuego_pressed():
	 get_tree().quit()
