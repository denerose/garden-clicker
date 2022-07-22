extends Node


#signal balancefail

onready var global = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func update_values():
	$UI/ScorePanel/CurrentScores/GoldBox/GoldValue.text = str(global.gold)
	$UI/ScorePanel/CurrentScores/GreenBox/GreenValue.text = str(global.green)
	$UI/ScorePanel/CurrentScores/PurpleBox/PurpleValue.text = str(global.purple)
	$UI/CountContainer/SuncountLabel.text = str(global.countSunflower)
	$UI/CountContainer/PinkcountLabel.text = str(global.countPinkflower)
	$UI/CountContainer/WhitecountLabel.text = str(global.countWhiteflower)
	$UI/CountContainer/LotuscountLabel.text = str(global.countLotus)
	$UI/Panel/PerSecondContainer/GoldPerSecBox/GoldPerSec.text = str(global.goldpersec)
	$UI/Panel/PerSecondContainer/PurplePerSecBox/PurplePerSec.text = str(global.purplepersec)
	$UI/Panel/PerSecondContainer/GreenPerSecBox/GreenPerSec.text = str(global.greenpersec)
	$UI/Panel/BuildingButtons/WhiteflowerButton.text = str(global.PlantingFee, "n")
	$UI/Panel/BuildingButtons/SunflowerButton.text = str(global.PlantingFee, "g" )
	$UI/Panel/BuildingButtons/PinkflowerButton.text = str(global.PlantingFee, "u")
	$UI/CountContainer/LotuscountLabel.text = str (global.countLotus)
	$UI/Panel/BuildingButtons/LotusButton.text = str (global.PlantingFee,"u + ",global.PlantingFee,"n")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if global.inBalance == false:
		$UI/BalancePopup.visible = true
	if global.inBalance:
		$UI/BalancePopup.visible = false
	update_values()

func _on_IncomeTimer_timeout():
	if global.inBalance:
		global.gold += 1*global.goldpersec
		global.green += 1*global.greenpersec
		global.purple += 1*global.purplepersec
		update_values()
	else:
		update_values()
#		emit_signal("balancefail")

func _on_GoldButton_pressed():
	if global.purple >0.01:
		global.gold += global.clickBuff
		global.purple -= global.clickBuff
		update_values()

func _on_PurpleButton_pressed():
	if global.green >0.01:
		global.purple += global.clickBuff
		global.green -= global.clickBuff
		update_values()

func _on_GreenButton_pressed():
	if global.gold >0.01:
		global.green += global.clickBuff
		global.gold -= global.clickBuff
		update_values()

#building placement buttons activate choice of plant or building to place
func _on_SunflowerButton_pressed():
	print("placing sunflower")
	global.currentlyPlacingBuilding = true
	global.buildingToPlace = 1

func _on_PinkflowerButton_pressed():
	print("placing pinkflower")
	global.currentlyPlacingBuilding = true
	global.buildingToPlace = 2

func _on_WhiteflowerButton_pressed():
	print("placing whiteflower")
	global.currentlyPlacingBuilding = true
	global.buildingToPlace = 3

func _on_ClearLandButton_pressed():
	print("cancel place")
	global.currentlyPlacingBuilding = false
	global.buildingToPlace = 0


func _on_DestroyButton_pressed():
	global.currentlyPlacingBuilding = true
	global.buildingToPlace = 4


func _on_LotusButton_pressed():
	print("placing lotus")
	global.currentlyPlacingBuilding = true
	global.buildingToPlace = 5


func _on_SaveButton_pressed():
	pass # Replace with function body.
