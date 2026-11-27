extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.xp_updated.connect(_on_xp_updated)
	_on_xp_updated()

func _on_xp_updated() -> void:
	$Label.text = str(Globals.stats.player.xp)
