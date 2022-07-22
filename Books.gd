extends HBoxContainer

onready var global = get_node("/root/Global")

func _on_RedBookButton_toggled(button_pressed):
	global.redbookactive = button_pressed
	

func _on_GreenBookButton_toggled(button_pressed):
	global.greenbookactive = button_pressed
	

func _on_BlueBookButton_toggled(button_pressed):
		global.bluebookactive = button_pressed
#	else:
#		$BlueBookButton.pressed = false

func _on_BlackBookButton_toggled(button_pressed):
	global.blackbookactive = button_pressed
