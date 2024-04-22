extends Node2D



signal nextPlayer
signal createFrog
signal createItem
signal showScore
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var maxShotLength = 400

var frogInScore = 1000

var frogPosition
var crosshairPosition
var accuracyBar
var playerID = 1
var turns = 1
var playersLeft = []

var itemPlacingPlayer = 1

var rounds = 1

var players = {}
var items = []

enum TurnOrder {START,AIMING, SHOOTING, FIRE, BUFFER,ITEMSELECTING, ITEMPLACING}
enum Items {FLY, DINO, BUBBLE, PORTAL}

var currentTurnState = TurnOrder.START;

var shotInformation = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	connect("nextPlayer",self, "nextPlayer") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	OS.set_window_title("Frolf" + " | FPS: " + str(Engine.get_frames_per_second()))
	turnManager()
	
func turnManager():
	if Input.is_action_just_pressed("select"):
		if currentTurnState == TurnOrder.AIMING:
			currentTurnState = TurnOrder.SHOOTING
		elif currentTurnState == TurnOrder.SHOOTING:
			currentTurnState = TurnOrder.FIRE
		elif currentTurnState == TurnOrder.ITEMPLACING:
			var item = Global.players[str(itemPlacingPlayer)]["item"]
			var posX = crosshairPosition.x
			var posY = crosshairPosition.y
			Global.items.append({"item": item, "x":posX, "y":posY})
			emit_signal("createItem",item,posX,posY)
			itemPlacingPlayer = itemPlacingPlayer + 1
			if itemPlacingPlayer > players.size():
				Global.turns = 1
				Global.frogInScore = 1000
				for x in players.size():
					players[str(x+1)]["frogPosX"] = 200
					players[str(x+1)]["frogPosY"] = 162
					players[str(x+1)]["frogIn"] = false
				for x in Global.players:
					Global.playersLeft.append(x)
				Global.emit_signal("nextPlayer", 0)
			

func nextPlayer(id):
	var counter = 0
	for x in Global.players:
		if (players[str(x)]["frogIn"]):
			counter += 1
	if counter == players.size():
		rounds = rounds + 1
		print("Round: " + str(rounds))
		if rounds > 4:
			print("We should be ending")
			get_tree().change_scene("res://WinnerScreen.tscn")
		else:
			get_tree().change_scene("res://ItemChoice.tscn")
	else:
		id = id + 1
		if id > players.size():
			id = 1
			turns += 1
			Global.frogInScore -= 100
		while (players[str(id)]["frogIn"] == true):
			id = id + 1
			if id > players.size():
				id = 1
				turns += 1
				Global.frogInScore -= 100
		if turns > 3:
			rounds = rounds + 1
			print("Round: " + str(rounds))
			if rounds > 4:
				print("We should be ending")
				get_tree().change_scene("res://WinnerScreen.tscn")
			else:
				get_tree().change_scene("res://ItemChoice.tscn")
		print("Id is: " + str(id))
		playerID = id
		yield(get_tree().create_timer(0.1), "timeout")
		print(Vector2(players[str(id)]["frogPosX"],players[str(id)]["frogPosY"]))
		frogPosition = Vector2(players[str(id)]["frogPosX"],players[str(id)]["frogPosY"])
		Global.emit_signal("createFrog",id, players[str(id)]["frogPosX"], players[str(id)]["frogPosY"])
