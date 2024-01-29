extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var value = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("createFrog",self,"createFrog") # Replace with function body.


func createFrog(id,x,y):
	global_position = Global.frogPosition

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$CanvasLayer/Player.text = "Player: " + str(Global.playerID)
	$CanvasLayer/Turn.text = "Turn: " + str(Global.turns)
	
	if Global.currentTurnState == Global.TurnOrder.ITEMPLACING:
		global_position = Global.crosshairPosition
	if Global.currentTurnState == Global.TurnOrder.SHOOTING:
		$CanvasLayer/AccuracyBar.visible = true
		
		value = value + 1.3
		if value > $CanvasLayer/AccuracyBar.max_value:
			value = $CanvasLayer/AccuracyBar.min_value
		$CanvasLayer/AccuracyBar.value = value
		Global.accuracyBar = value
	else:
		$CanvasLayer/AccuracyBar.visible = false
