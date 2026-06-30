bottles.register_filled_bottle({
    target = { "default:water_source", "default:water_flowing" },
    sound = "default_water_footstep",
    name = "water_bottle",
    description = "Bottle of Water",
})
core.override_item("bottles:water_bottle", {
    groups = { vessel = 1, dig_immediate = 3, attached_node = 1, food_water = 1 }
})
bottles.register_filled_bottle({
  target = {"default:river_water_source","default:river_water_flowing"},
  sound = "default_water_footstep",
  name = "river_water_bottle",
  description = "Bottle of River Water",
})
core.override_item("bottles:river_water_bottle", {
    groups = { vessel = 1, dig_immediate = 3, attached_node = 1, food_water = 1 }
})
if core.get_modpath('bottles_default') then
    core.register_alias_force("bottles:water_bottle", "bottles_default:bottle_of_water")
    core.register_alias_force("bottles:river_water_bottle", "bottles_default:bottle_of_river_water")
end