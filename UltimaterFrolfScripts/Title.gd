extends Node2D

var playerNum = 2
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$SelectyThing/Label2.text = str(playerNum)


func _on_RightButton_pressed():
	playerNum = playerNum + 1
	if playerNum > 4:
		playerNum = 4 # Replace with function body.


func _on_LeftButton_pressed():
	playerNum = playerNum - 1
	if playerNum < 2:
		playerNum = 2 # Replace with function body.


func _on_StartButton_pressed():
	for x in playerNum:
		Global.players[str(x+1)] = {"frogPosX": 200, "frogPosY":162, "score":0, "item":0, "frogIn": false}
	for x in Global.players:
		Global.playersLeft.append(x)
	Global.emit_signal("nextPlayer", 0)
	get_tree().change_scene("res://World.tscn") # Replace with function body.


func _on_LinkButton_pressed():
	get_tree().change_scene("res://HowToPlay.tscn")
