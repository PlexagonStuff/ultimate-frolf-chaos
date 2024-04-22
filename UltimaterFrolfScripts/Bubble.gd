extends StaticBody2D

var rng = RandomNumberGenerator.new()

var score
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	score = (rng.randi_range(1,5)*100)
	$Label.text = "+" + str(score)# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Bubble_area_entered(area):
	Global.players[str(area.get_parent().player)]["score"] += score
	Global.emit_signal("showScore",score)
	queue_free() # Replace with function body.
