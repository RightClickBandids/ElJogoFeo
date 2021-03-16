extends Spatial


var camaraHorizontal=0
var camaraVertical=0

var CVerticalMin=75
var CVerticalMax=-75
var hSensibilidad=0.1
var vSensibilidad=0.1
var hAceleracion=10
var Vaceleracion=10

func _ready():
	
	$ControlHorizontal/ControlVertical/Camara.add_exception(get_parent())
	
func _input(event):
	if event is InputEventMouseMotion:
		camaraHorizontal+=-event.relative.x * hSensibilidad
		camaraVertical+=-event.relative.y * vSensibilidad
		
func _physics_process(delta):
	
	$ControlHorizontal.rotation_degrees.y=lerp($ControlHorizontal.rotation_degrees.y,camaraHorizontal,delta * hAceleracion)
	$ControlHorizontal/ControlVertical.rotation_degrees.x=lerp($ControlHorizontal/ControlVertical.rotation_degrees.x, camaraVertical,delta * Vaceleracion)
