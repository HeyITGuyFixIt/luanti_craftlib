craftlib.register_craft({
    type = "carve",
    base = {"group:slab"},
    tool = { "group:chisel", "group:axe" },
    pattern = {
        {0, 0, 0, 0, 0, 0, 0, 0},
        {0, 1, 1, 1, 1, 1, 1, 0},
        {0, 0, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 1, 1, 0, 0, 0},
        {0, 0, 0, 1, 1, 0, 0, 0},
        {0, 0, 1, 1, 1, 1, 0, 0},
        {0, 1, 1, 1, 1, 1, 1, 0},
        {0, 0, 0, 0, 0, 0, 0, 0}
    },
    output = { "metalworking:pattern_anvil" }
})

core.register_node("metalworking:pattern_anvil", {
    name = "Metal Anvil Pattern",
})

metalworking.remove_material("default", "wood", true, false)
metalworking.remove_material("default", "stone", true, false)
metalworking.remove_material("default", "steel", true, true)
metalworking.remove_material("default", "bronze", true, false)
metalworking.remove_material("default", "copper", false, true)
metalworking.remove_material("default", "gold", false, true)
metalworking.remove_material("default", "tin", false, true)
metalworking.remove_material("default", "mese", true, false)
metalworking.remove_material("default", "diamond", true, false)
if core.get_modpath("ethereal") then
    metalworking.remove_material("ethereal", "crystal", true, false)
end
