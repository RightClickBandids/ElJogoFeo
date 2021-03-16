extends KinematicBody
#DECLARAR UNA VARIABLE PARA TRABAJAR LOS TRES EJES 

var movJugador=Vector3()
const up=Vector3(0,1,0)
export var numJugador=1
export var avance=10
#	VARIABLES NOS PERMITIRAN CONTROLAR LA ANIMACION A TRAVEZ DEL 
var movEstado=0
const minBlendSpeed=0.125
const blendCorrer=0.075
const blendIniciar=0.01


#variable del disparo
const velDisparo=500

func disparar():
	
	var disparo=load("res://Disparo.tscn").instance()
	
	add_child(disparo)
	
	disparo.set_as_toplevel(true)
	
	disparo.global_transform=$ControlCamara/ControlHorizontal/ControlVertical/Frente.global_transform
	
	
	
	disparo.linear_velocity= disparo.global_transform.basis.x * velDisparo
	
func _input(event):
	if Input.is_action_just_pressed("Disparo"):
		disparar()
	

func _physics_process(delta):
	movimiento()
	animacionTree()
	
	
	
	
func movimiento():
	var moverDir=moverDosDireccion()
	var dirCamara=Vector3.ZERO	
	var camaraX=$ControlCamara/ControlHorizontal/ControlVertical/Camara.global_transform
	
	dirCamara -= camaraX.basis.z.normalized()*moverDir.x
	dirCamara += camaraX.basis.x.normalized()*moverDir.y
	
	movJugador=dirCamara
	
	move_and_slide(movJugador * avance,up)
	
func moverDosDireccion():	
	var x=Input.get_action_strength("abajoJugador%s"%numJugador)-Input.get_action_strength("arribaJugador%s"%numJugador)
	var y=Input.get_action_strength("derechaJugador%s"%numJugador)-Input.get_action_strength("izquierdaJugador%s"%numJugador)
		
	var movDir=Vector2(x,y)
	
	if not movDir== Vector2.ZERO:
			moverCaraTree(x,y)
	return movDir.normalized()		

#func movimiento():
	#var z=Input.get_action_strength("abajoJugador%s"%numJugador)-Input.get_action_strength("arribaJugador%s"%numJugador)
	#var x=Input.get_action_strength("izquierdaJugdor%s"%numJugador)-Input.get_action_strength("derechaJugador%s"%numJugador)
	
	#movJugador=Vector3(x,0,z)
	
	#if not movJugador== Vector3(0,0,0):
		#moverCaraTree(x,z)
	
	#move_and_slide(movJugador * avance,up)
	
func moverCaraTree(x,z):
	rotation.y=atan2(x,z-PI*2)


func animacionTree():
	if (movJugador*avance).length()>minBlendSpeed:
		movEstado+=blendCorrer
	else:
		movEstado-=blendIniciar
		
	movEstado=clamp(movEstado,0,1)
	var animacionJ=$AnimatedHuman/AnimationTree
	animacionJ["parameters/mover/blend_amount"]=movEstado
