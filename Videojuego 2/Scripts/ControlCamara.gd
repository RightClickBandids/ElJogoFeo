extends Spatial

var camaraHorizontal=0
var camaraVertical=0
#variables para controlar la sensibilidad 
var cVerticalMin=75
var cVerticalMax=-75
var hsensibilidad=0.1
var vsensibilidad=0.1
var hAceleracion=10
var vAceleracion=10





func _ready():
	$ControlHorizontal/ControlVertical/ClippedCamera.add_exception(get_parent())
func _input(event):
	if event is InputEventMouseMotion:
		camaraHorizontal+=-event.relative.x*hsensibilidad
		camaraVertical+=-event.relative.y*vsensibilidad
		
func _physics_process(delta):
	$ControlHorizontal.rotation_degrees.y=lerp($ControlHorizontal.rotation_degrees.y,camaraHorizontal,delta * hAceleracion)	
	$ControlHorizontal/ControlVertical.rotation_degrees.x=lerp($ControlHorizontal/ControlVertical.rotation_degrees.x,camaraVertical,delta * vAceleracion)
