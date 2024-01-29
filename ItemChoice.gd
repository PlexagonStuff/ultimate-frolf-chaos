extends Node2D


var order = Global.players.keys()
var index = 0
var currentPlayer
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	Global.currentTurnState = Global.TurnOrder.ITEMSELECTING
	Global.itemPlacingPlayer = 1
	currentPlayer = order[index] # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Portal_pressed():
	Global.players[currentPlayer]["item"] = Global.Items.PORTAL
	Global.players[currentPlayer]["frogPosX"] = 200
	Global.players[currentPlayer]["frogPosY"] = 400
	index = index + 1
	if (index > (order.size()-1)):
		Global.currentTurnState = Global.TurnOrder.ITEMPLACING
		get_tree().change_scene("res://World.tscn")
	else:
		currentPlayer = order[index]
	$BlackHole.queue_free()
	 # Replace with function body.


func _on_Bubble_pressed():
	Global.players[currentPlayer]["item"] = Global.Items.BUBBLE
	Global.players[currentPlayer]["frogPosX"] = 200
	Global.players[currentPlayer]["frogPosY"] = 400
	index = index + 1
	if (index > (order.size()-1)):
		Global.currentTurnState = Global.TurnOrder.ITEMPLACING
		get_tree().change_scene("res://World.tscn")
	else:
		currentPlayer = order[index]
	$Bubble.queue_free() # Replace with function body.


func _on_Fly_pressed():
	Global.players[currentPlayer]["item"] = Global.Items.FLY
	Global.players[currentPlayer]["frogPosX"] = 200
	Global.players[currentPlayer]["frogPosY"] = 400
	index = index + 1
	if (index > (order.size()-1)):
		Global.currentTurnState = Global.TurnOrder.ITEMPLACING
		get_tree().change_scene("res://World.tscn")
	else:
		currentPlayer = order[index]
	$Fly.queue_free()


func _on_Snake_pressed():
	Global.players[currentPlayer]["item"] = Global.Items.DINO
	Global.players[currentPlayer]["frogPosX"] = 200
	Global.players[currentPlayer]["frogPosY"] = 400
	index = index + 1
	if (index > (order.size()-1)):
		Global.currentTurnState = Global.TurnOrder.ITEMPLACING
		get_tree().change_scene("res://World.tscn")
	else:
		currentPlayer = order[index]
	$Snake.queue_free()
