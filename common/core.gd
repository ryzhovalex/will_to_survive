extends Node

func get_current_scene() -> Node:
	return get_tree().get_current_scene()

# Fetches node relative to scene
func find(t: String = ".") -> Node:
	return get_tree().get_current_scene().get_node(t)

func time() -> int:
	return Time.get_ticks_msec()

func utc() -> int:
	return floor(Time.get_unix_time_from_system() * 1000)

func is_cooldown(
	last: int, cooldown: int, unlock_starters: bool = true
) -> bool:
	# By default make cooldowns unlocked at the start of the engine
	if unlock_starters && last == 0:
		return false
	return time() - last <= cooldown

func percent(current_val: float, max_val: float) -> float:
	return current_val / max_val

func get_viewport_mouse_pos() -> Vector2:
	return get_viewport().get_mouse_position()

func get_group_members(group: StringName) -> Array[Node]:
	return get_tree().get_nodes_in_group(group)
