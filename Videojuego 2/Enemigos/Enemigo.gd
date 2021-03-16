extends KinematicBody


var ComienzoDisparo=true
var velDisparo=50

func _physics_process(delta):
	
	if $RayCast.is_colliding():
		
		dispararAhora()
		
func dispararAhora():
	if ComienzoDisparo:
		disparar()
		ComienzoDisparo=false
		$Timer.start()
		
func disparar():
	var disparos=load("res://Scenes/Disparos/Disparo1.tscn").instance()
	add_child(disparos)
	disparos.set_as_toplevel(true)
	disparos.global_transform=$Position3D.global_transform
	disparos.linear_velocity= disparos.global_transform.basis.x*velDisparo
	

func _on_Timer_timeout():
	inicioDisparo=true
