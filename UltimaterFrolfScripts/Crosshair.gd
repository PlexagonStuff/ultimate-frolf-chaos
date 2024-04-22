extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("createFrog",self,"createFrog")
	
func createFrog(id,x,y):
	global_position = Global.frogPosition # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if Global.currentTurnState == Global.TurnOrder.AIMING:
		visible = true
		var velocity = Input.get_vector("left", "right", "up", "down")
		velocity = 1.5*velocity
		#print("Crosshair Velocity: " + str(velocity))
		if (global_position.distance_to(Global.frogPosition) < Global.maxShotLength):
			global_position = global_position + velocity
		else:
			global_position = global_position + (2*global_position.direction_to(Global.frogPosition))
			
		Global.crosshairPosition = global_position
	elif Global.currentTurnState == Global.TurnOrder.ITEMPLACING:
		visible = true
		var velocity = Input.get_vector("left", "right", "up", "down")
		velocity = 1.5*velocity
		global_position = global_position + velocity
		Global.crosshairPosition = global_position
		#visible = false
