extends KinematicBody
var contador=0
var movJugador=Vector3()
const up=Vector3(0,1,0)
export var numJugador=2
export var avance=10
onready var label=$Overlay/NinePatchRect/HBoxContainer/Label2

var moverEstado=0  
const minBlendSpeed=0.125
const blendCorrer=0.075
const blendIniciar=0.01
const velDisparo=50
var tiposDisparos={}
var iniciarDisparo=true

func _ready():
	tiposDisparos=DisparosAleatorios.obtenerRutaEscena("res://Scenes/Disparos/")
	randomize()
func dispararAhora():
	if iniciarDisparo==true:
		disparo()
		iniciarDisparo=false
		$Timer.start()
func disparo():
	var disparosAleatorios=tiposDisparos[randi()%tiposDisparos.size()]
	var disparos=load(disparosAleatorios).instance()
	add_child(disparos)
	disparos.set_as_toplevel(true)
	disparos.global_transform=$ControlCamara/ControlHorizontal/ControlVertical/Frente.global_transform
	disparos.linear_velocity=disparos.global_transform.basis.x * velDisparo
func _input(event):
	if Input.is_action_pressed("disparo"):
		dispararAhora()
func _physics_process(delta):	
	movimiento()	
	animacionTree()
func movimiento():
	var moverDir=moverDosDireccion()
	var dirCamara=Vector3.ZERO
	var camaraX=$ControlCamara/ControlHorizontal/ControlVertical/ClippedCamera.global_transform
	
	dirCamara -= camaraX.basis.z.normalized()*moverDir.x
	dirCamara += camaraX.basis.x.normalized()*moverDir.y
	dirCamara.y=0
	
	movJugador=dirCamara
	
	move_and_slide(movJugador * avance,up)

func moverDosDireccion():	
	var x=Input.get_action_strength("arriba")-Input.get_action_strength("abajo")
	var y=Input.get_action_strength("derecha")-Input.get_action_strength("izquierda")

	var movDir=Vector2(x,y)
	
	if not movDir== Vector2.ZERO:
			moverCaraTree(x,y)

	return movDir.normalized()		
func moverCaraTree(x,y):	
	#movimiento camara
	rotation.y=atan2(x,y-PI*2)
func animacionTree():
	
	if (movJugador*avance).length()>minBlendSpeed:
		moverEstado+=blendCorrer
	else:
		moverEstado-=blendIniciar
		
	moverEstado=clamp(moverEstado,0,1)	
	
	var animacionJ=$AnimatedHuman/AnimationTree
	
	animacionJ["parameters/Mover/blend_amount"]=moverEstado
func _on_Timer_timeout():
	iniciarDisparo=true
func _on_Area_area_entered(area):
	contador=contador+1
	print("CONTADOR: ",contador)
func _on_Area_body_shape_entered(body_id, body, body_shape, area_shape):
	contador=contador+1
	print("CONTADOR: ",contador)
