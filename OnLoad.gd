extends Node

export (PackedScene) var TextCard

func _ready():
	var text_card = TextCard.instance()
	$"..".call_deferred("add_child",text_card)
	text_card.textContent = "Good morning, John."
	text_card.maxTimer = 2;
