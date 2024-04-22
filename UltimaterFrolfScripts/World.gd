extends Node2D
onready var frogData = preload("res://Frog.tscn")
onready var portalData = preload("res://Portal.tscn")
onready var dinoData = preload("res://Dino.tscn")
onready var flyData = preload("res://Fly.tscn")
onready var bubbleData = preload("res://Bubble.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.connect("createFrog",self,"createFrog")
	Global.connect("createItem",self,"createItem")
	for x in Global.items:
		print(x)
		Global.emit_signal("createItem",x["item"],x["x"],x["y"])
	 # Replace with function body.
	
func createItem(item, x, y):
	var data
	if item == Global.Items.FLY:
		data = flyData
	elif item == Global.Items.BUBBLE:
		data = bubbleData
	elif item == Global.Items.DINO:
		data = dinoData
	else:
		data = portalData
	var thing = data.instance()
	thing.global_position = Vector2(x,y)
	$ItemContainer.add_child(thing)


func createFrog(id, x, y):
	var frog = frogData.instance()
	print(Vector2(x,y))
	frog.global_position = Vector2(x,y)
	Global.frogPosition = Vector2(x,y)
	frog.player = id
	add_child(frog)
	Global.currentTurnState = Global.TurnOrder.AIMING
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# Replace with function body.
