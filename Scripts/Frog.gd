extends KinematicBody2D

signal shootFrog

var rng = RandomNumberGenerator.new()

var _delta
var player
var sequence = 1
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	connect("shootFrog", self, "shootFrog")
	yield(get_tree().create_timer(0.2), "timeout")
	print(global_position)
	print($Area2D.get_overlapping_bodies())
	if ($Area2D.get_overlapping_bodies().size() > 0):
		var surface = evaluateSurface()[0]
		if (surface == "Fairway"):
			Global.maxShotLength = 400
		if (surface == "Grass"):
			Global.maxShotLength = 200
		if (surface == "Rough"):
			Global.maxShotLength = 100


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func evaluateSurface():
	var surface = ["Bad","Bad"]
	if ($Area2D.get_overlapping_bodies().size() > 0):
		surface[0] = str($Area2D.get_overlapping_bodies()[0]).split(":")[0]
	if ($Area2D.get_overlapping_areas().size() > 0):
		surface[1] = str($Area2D.get_overlapping_areas()[0]).split(":")[0]
	print(surface)
	return surface

func _physics_process(delta):
	_delta = delta
	#print($Area2D.get_overlapping_bodies())
	Global.frogPosition = global_position
	if Global.currentTurnState == Global.TurnOrder.FIRE:
		Global.currentTurnState = Global.TurnOrder.BUFFER
		emit_signal("shootFrog")
		
func shootFrog():
	var position = Global.crosshairPosition
	var accuracy = Global.accuracyBar
	var shootPosition = position + Vector2(rng.randf_range((-(100-accuracy)*2), (100-accuracy)*2),rng.randf_range((-(100-accuracy)*2), (100-accuracy)*2))
	var ogDistance = global_position.distance_to(shootPosition)
	var direction = global_position.direction_to(shootPosition)
	var initVelocity = direction * 5
	var velocity = initVelocity
	while (global_position.distance_to(shootPosition) > 6):
		velocity = initVelocity - (direction * (pow((ogDistance -global_position.distance_to(shootPosition)),0.25)))
		#print("Acceleration: " + str(pow(global_position.distance_to(shootPosition),0.25)))
		global_position = global_position + velocity 
		yield(get_tree().create_timer(0.001), "timeout")
	#BOUNCE TIME!!!
	var surface = evaluateSurface()
	if (surface[1] == "Hole"):
		Global.players[str(player)]["score"] = Global.players[str(player)]["score"] + 1000
		Global.players[str(player)]["frogIn"] = true
		Global.players[str(player)]["frogPosX"] = global_position.x
		Global.players[str(player)]["frogPosY"] = global_position.y
		yield(get_tree().create_timer(0.3), "timeout")
		Global.emit_signal("nextPlayer",player)
		queue_free()
	elif surface[1] == "Fly":
		sequence = 0
		direction = global_position.direction_to($Area2D.get_overlapping_areas()[0].get_parent().global_position)
		$Area2D.get_overlapping_areas()[0].get_parent().queue_free()
		jump(direction)
	elif surface[1] == "Dino":
		sequence = 0
		direction = Vector2(rng.randi_range(-1,1),rng.randi_range(-1,1)).normalized()
		jump(direction)
	else:
		jump(direction)
	
func jump(direction):
	yield(get_tree().create_timer(0.5), "timeout")
	sequence = sequence + 1
	if sequence > 2:
		print("Before: " + str(Global.players[str(player)]))
		Global.players[str(player)]["frogPosX"] = global_position.x
		Global.players[str(player)]["frogPosY"] = global_position.y
		print("After: " + str(Global.players[str(player)]))
		print("Frog finished?")
		Global.emit_signal("nextPlayer",player)
		queue_free()
	var shootPosition = global_position + (direction* (rng.randi_range(50, 100)))
	var ogDistance = global_position.distance_to(shootPosition)
	var initVelocity = direction * 5
	var velocity = initVelocity
	while (global_position.distance_to(shootPosition) > 6):
		velocity = initVelocity - (direction * (pow((ogDistance -global_position.distance_to(shootPosition)),0.25)))
		#print("Acceleration: " + str(pow(global_position.distance_to(shootPosition),0.25)))
		global_position = global_position + velocity 
		yield(get_tree().create_timer(0.001), "timeout")
	yield(get_tree().create_timer(0.3), "timeout")
	var surface = evaluateSurface()
	if (surface[1] == "Hole"):
		Global.players[str(player)]["score"] = Global.players[str(player)]["score"] + 1000
		Global.players[str(player)]["frogIn"] = true
		Global.players[str(player)]["frogPosX"] = global_position.x
		Global.players[str(player)]["frogPosY"] = global_position.y
		yield(get_tree().create_timer(0.3), "timeout")
		Global.emit_signal("nextPlayer",player)
		queue_free()
	elif surface[1] == "Fly":
		sequence = 0
		direction = global_position.direction_to($Area2D.get_overlapping_areas()[0].get_parent().global_position)
		$Area2D.get_overlapping_areas()[0].get_parent().queue_free()
		jump(direction)
	elif surface[1] == "Dino":
		sequence = 0
		direction = Vector2(rng.randi_range(-1,1),rng.randi_range(-1,1)).normalized()
		jump(direction)
	else:
		jump(direction)
	
		
		
	
	
