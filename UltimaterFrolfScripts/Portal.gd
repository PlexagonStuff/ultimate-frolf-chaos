extends StaticBody2D

var rng = RandomNumberGenerator.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Portal_area_entered(area):
	var navMesh = area.get_parent().get_parent().get_node("FrolfCourse").get_node("PortalSpawn")
	var spawnPoint = navMesh.get_closest_point(Vector2(rng.randi_range(52,1178),rng.randi_range(-17,534)))
	var player = area.get_parent().player
	print(spawnPoint)
	area.get_parent().global_position = spawnPoint
	area.get_parent().sequence = 1
	Global.players[str(area.get_parent().player)]["frogPosX"] = spawnPoint.x
	Global.players[str(area.get_parent().player)]["frogPosY"] = spawnPoint.y
	area.get_parent().queue_free()
	yield(get_tree().create_timer(0.3), "timeout")
	Global.emit_signal("nextPlayer",player)
	var direction = Vector2(rng.randi_range(-1,1),rng.randi_range(-1,1)).normalized()
	#area.get_parent().jump(direction)
