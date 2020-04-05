extends Node

export (PackedScene) var TextCard

onready var pause_menu = $"../CanvasLayer/PauseMenu"
onready var pause_menu_ready

func _ready():
	var text_card = TextCard.instance()
	$"..".call_deferred("add_child",text_card)
	text_card.textContent = "Good morning, John."
	text_card.maxTimer = 2
	pause_menu.connect('ready', self, '_on_PauseMenu_ready')
	text_card.connect('tree_exited', self, '_on_TextCard_tree_exited')

func _on_PauseMenu_ready():
	# pause_menu.disable()
	pass

func _on_TextCard_tree_exited():
	print('pause menu enabled')
	pause_menu.enable()
