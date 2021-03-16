extends KinematicBody


var contador=0
var movJugador=Vector3()
const up=Vector3(0,1,0)
export var numJugador=2
export var avance=10
onready var label=$Overlay/NinePatchRect/HBoxContainer/Label2
#variables para control de la animación en base al AnimationTree

#0--> se ejecuta la animación Idle, 1-->se ejecuta Run
var moverEstado=0  
#velocidad minima para detener la animación
const minBlendSpeed=0.125
#velocidad de la animación Run
const blendCorrer=0.075
#velocidad para regresar a inicio y detenerse
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
	#se crea una instancia de la escena
	#var disparos=load("res://DisparoClase.tscn").instance()

	var disparosAleatorios=tiposDisparos[randi()%tiposDisparos.size()]
	var disparos=load(disparosAleatorios).instance()
	#it is added as a child to be able to access it 
	add_child(disparos)
	#we use a function to make it work in the top level
	disparos.set_as_toplevel(true)
	#se verifica la posicion del frente
	disparos.global_transform=$ControlCamara/ControlHorizontal/ControlVertical/Frente.global_transform
	#se accede al disparo (rigid body)
	disparos.linear_velocity=disparos.global_transform.basis.x * velDisparo

func _input(event):
	if Input.is_action_pressed("DISPARO"):
		dispararAhora()

func _physics_process(delta):	
	movimiento()	
	animacionTree()
	
	
#Va tomar la dirección de acuerdo a la dirección de la cámara
func movimiento():
	#obtiene la dirección en la que deberá moverse de acuerdo a la tecla presionada
	var moverDir=moverDosDireccion()
	#variable para manejo de la dirección de la cámara
	var dirCamara=Vector3.ZERO	 #Vector3(0,0,0)
	var camaraX=$ControlCamara/ControlHorizontal/ControlVertical/Camara.global_transform
	
	
	#obtiene la dirección actual de camara
	dirCamara -= camaraX.basis.z.normalized()*moverDir.x
	dirCamara += camaraX.basis.x.normalized()*moverDir.y
	dirCamara.y=0
	
	movJugador=dirCamara
	
	move_and_slide(movJugador * avance,up)
		
func moverDosDireccion():	
	var x=Input.get_action_strength("UP")-Input.get_action_strength("DOWN")
	var y=Input.get_action_strength("RIGHT")-Input.get_action_strength("LEFT")
	#se movera de acuerdo al vector 2	
	var movDir=Vector2(x,y)
	
	if not movDir== Vector2.ZERO:
			moverCaraTree(x,y)
	#regresa la dirección a la cual debe moverse		
	return movDir.normalized()		
		
func moverCaraTree(x,y):	
	#realiza la rotación de la cara
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
