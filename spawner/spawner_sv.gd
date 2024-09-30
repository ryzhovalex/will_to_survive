extends Sv

# How often to call spawn instruction
@export var period: int = 1000
@export var spawned_scene: PackedScene
@export var spawned_rnd_stats: Array[MobStat]
@export var spawn_offset_x_mul: float = 0.75

var last_spawned: int = 0

func init():
    last_spawned = 0

func _process(_delta):
    if core.is_cooldown(last_spawned, period):
        last_spawned = core.time()
        var chosen_stat: MobStat = spawned_rnd_stats.pick_random()
        if chosen_stat == null:
            printerr("No content in `spawned_rnd_stats` array")
            return
        var chosen: Mob = spawned_scene.instantiate()
        chosen.stat = chosen_stat

        var visible_rect := get_viewport().get_visible_rect()
        # Spawn a little bit offscreen
        var spawn_offset_x_from_visible_rect_center: int = \
            floor(visible_rect.size.x * spawn_offset_x_mul)
        var visible_rect_center := visible_rect.get_center()
        var final_pos_x := \
            visible_rect_center.x + spawn_offset_x_from_visible_rect_center
        var final_pos_y := GroundSv.base_y
        chosen.position = Vector2(final_pos_x, final_pos_y)

        var parent_node := core.find()
        assert(parent_node != null)
        parent_node.add_child(chosen)
