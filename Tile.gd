extends Area2D


# do we have a building on this tile?
var hasBuilding : bool = false

# can we place a building on this tile?
var canPlaceBuilding : bool = true
var mouse_inside_area: bool = false

#what building is this?
var buildingType = "dirt"

# pre-load and on ready vars
onready var highlight : Sprite = get_node("Highlight")
onready var sunflowerSprite : Sprite = get_node("SunflowerSprite")
onready var pinkflowerSprite : Sprite = get_node("PinkflowerSprite")
onready var whiteflowerSprite : Sprite = get_node("WhiteflowerSprite")
onready var LotusSprite : Sprite = get_node("LotusSprite")
onready var ui_select
onready var global = get_node("/root/Global")


# called once when the node is initialized
func _ready ():
	# add the tile to the "Tiles" group when the node is initialized
	add_to_group("Tiles")
	highlight.visible = false

func _on_Tile_mouse_entered():
	if canPlaceBuilding and global.currentlyPlacingBuilding:
		highlight.visible = true
	mouse_inside_area = true

func _on_Tile_mouse_exited():
	highlight.visible = false
	mouse_inside_area = false

func clear_Tile(): #make sure no sprites are showing and reset tile to just ground layer
	sunflowerSprite.visible = false
	pinkflowerSprite.visible = false
	whiteflowerSprite.visible = false
	LotusSprite.visible = false

func tilePlaced(): #clear global values and stop user from replacing building on this tile
	self.hasBuilding = true
	self.canPlaceBuilding = false
#	global.currentlyPlacingBuilding = false
#	global.buildingToPlace = 0

func newSunflower():
	global.countSunflower += 1
	global.gold -= global.PlantingFee
	sunflowerSprite.visible = true
	self.buildingType = "sun"

func newPinkflower():
	global.countPinkflower += 1
	global.purple -= global.PlantingFee
	pinkflowerSprite.visible = true
	buildingType = "pink"
	
func newWhiteflower():
	global.countWhiteflower += 1
	global.green -= global.PlantingFee
	whiteflowerSprite.visible = true
	buildingType = "white"
	
func newLotus():
	global.countLotus += 1
	global.purple -= global.PlantingFee
	global.green -= global.PlantingFee
	LotusSprite.visible = true
	buildingType = "lotus"
	
func removeBuilding():
	if self.buildingType == "sun":
		global.countSunflower -=1
	elif self.buildingType == "white":
			global.countWhiteflower -=1
	elif self.buildingType == "pink":
			global.countPinkflower -=1
	elif self.buildingType == "lotus":
		global.countLotus -= 1
	self.canPlaceBuilding = true
	self.hasBuilding = false

func _input(event):
	if Input.is_action_pressed("ui_select") and mouse_inside_area:
#		print("clicked", str(self.position))
		
# place a sunflower
		if global.gold > global.PlantingFee-1 and canPlaceBuilding and global.buildingToPlace == 1: 
			clear_Tile()
			tilePlaced()
			newSunflower()

#place a pinkflower
		elif global.purple > global.PlantingFee-1 and canPlaceBuilding and global.buildingToPlace == 2: 
			clear_Tile()
			tilePlaced()
			newPinkflower()
			
 #place a whiteflower
		elif global.green > global.PlantingFee-1 and canPlaceBuilding and global.buildingToPlace == 3:
			clear_Tile()
			tilePlaced()
			newWhiteflower()
			
#place a lotus
		elif global.green > global.PlantingFee-1 and global.green > global.PlantingFee-1 and canPlaceBuilding and global.buildingToPlace == 5: 
			clear_Tile()
			tilePlaced()
			newLotus()
			
		elif global.currentlyPlacingBuilding and hasBuilding and global.buildingToPlace == 4: #destroy the plant or building
			clear_Tile()
			removeBuilding()


		elif global.buildingToPlace == 0: #nothing to plant
			print ("nothing to place")
		
		elif not canPlaceBuilding:
			print ("already occupied")
