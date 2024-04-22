extends Node2D

var highestScore = 0
var highestPlayer = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	highestScore = 0
	highestPlayer = 0
	for x in Global.players:
		if (Global.players[str(x)]["score"] > highestScore):
			highestScore = Global.players[str(x)]["score"]
			highestPlayer = x
	 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AudioStreamPlayer_finished():
	$AudioStreamPlayer2.play()
	$Label.text = "Player " + str(highestPlayer) + " won!"
