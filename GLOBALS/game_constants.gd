class_name GameUtils
extends RefCounted

const Z_INDEX = {
	"TILEMAPS": 1,
	"AREA": 1,
	"PLAYER": 2,
	"BULLET": 3,
	"OVER_PLAYER": 5,
	"ENEMIES": 10
}

static func is_player(body: Node2D) -> bool:
	return body.get_groups().has("player")
