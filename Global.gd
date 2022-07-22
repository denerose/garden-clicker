extends Node

# Funds (total current value)
var purple: int = 30
var gold: int = 30
var green: int = 30

# Income per second (for timers)
var greenpersec: int = 0
var goldpersec: int = 0
var purplepersec: int = 0

#Value per click
var clickBuff: int = 1

#count of buildings used to calc per second values
var countSunflower = 0
var countPinkflower = 0
var countWhiteflower = 0
var countLotus = 0
var countPlants: int = countPinkflower + countSunflower + countWhiteflower

#counter buffs bld count * colour buff = per sec value
var pinkBuff = 2
var whiteBuff = 2
var goldBuff = 2
var costBuff = 1 #base amount charged per sec fr buildings

var PlantingFee = 10

#vars for booster books
var redbookactive = false
var bluebookactive = false
var blackbookactive = false
var greenbookactive = false

#gameplay values - controls for what it being controlled
# are we currently placing down a building?
var currentlyPlacingBuilding: bool = false

# type of building we're currently placing
var buildingToPlace: = 0

#are all funds above 1
var inBalance: bool = true

#functions

func calcBuffs():
	pinkBuff = 2
	whiteBuff = 2
	goldBuff = 2
	costBuff = 1
	
	if redbookactive:
		goldBuff = countSunflower
	if bluebookactive:
		pinkBuff = countPinkflower
	if greenbookactive:
		whiteBuff = countWhiteflower

	if blackbookactive:
		clickBuff = 10
		

func calcGold():
	goldpersec = countSunflower*goldBuff
	goldpersec -= countWhiteflower*whiteBuff/2
	goldpersec -= countLotus*2
	
func calcPurple():
	purplepersec = countPinkflower*pinkBuff
	purplepersec += countLotus
	purplepersec -= countSunflower*goldBuff/2
	
func calcGreen():
	greenpersec = countWhiteflower*whiteBuff
	greenpersec += countLotus
	greenpersec -= countPinkflower*pinkBuff/2
	
func calcPlantFee():
	if countPlants < 10:
		PlantingFee = 10 + countPlants
	elif countPlants > 10 && countPlants < 30:
		PlantingFee = 2 * countPlants
	elif countPlants > 30:
		PlantingFee = 3 * countPlants
		
		
func calcPlants():
	countPlants = countPinkflower + countSunflower + countWhiteflower + countLotus

func _process(_delta):
	if gold > 0 and green > 0 and purple > 0 and goldpersec > -1 and purplepersec > -1 and greenpersec > -1:
		inBalance = true
	else:
		inBalance = false
	
	#make sure values are sane
#	if gold <-10:
#		gold = -10
#	if green <-10:
#		green = -10
#	if purple <-10:
#		purple = -10
	if countSunflower <0:
		countSunflower = 0
	if countPinkflower <0:
		countPinkflower = 0
	if countWhiteflower <0:
		countWhiteflower = 0
	if countLotus <0:
		countLotus = 0

func _on_CalcTimer_timeout():
	calcPlants()
	calcBuffs()
	calcGold()
	calcPurple()
	calcGreen()
	calcPlantFee()
