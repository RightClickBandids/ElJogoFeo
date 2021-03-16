extends Node

func obtenerRutaEscena(ruta):
	#contenedor de las escenas de disparos (diferentes tipos de disparos)
	var archivosDisparos={}
	#cuenta cuantos archivos exsiten en la carpeta ArchivosDisparos
	var numArchivo=0
	#crear un directorio con las escenas que estamos creando
	var direccion=Directory.new()
	
	direccion.open(ruta)
	direccion.list_dir_begin()
	
	while true:
		var archivo=direccion.get_next()
		if archivo=="":
			break;
		elif not archivo.begins_with("."):
			archivosDisparos[numArchivo]=ruta+archivo
			numArchivo+=1
			
	return archivosDisparos
