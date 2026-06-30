local S = minetest.get_translator(minetest.get_current_modname())

craftlib.register_craft({
    type = "craft",
    base = { "crafting_mtg:crafttable" },
    input = {
        "group:stick 2",
        "group:wood"
    },
    tool = { "" },
    output = { "cooking:wooden_bowl" }
})

core.register_node("cooking:wooden_bowl", {
    description = S("Bowl"),
    drawtype = "plantlike",
    tiles = { "default_wood.png" },
    inventory_image = "biometer_bowl_inv_minetest_game.png",
    wield_image = "biometer_bowl_minetest_game.png",
    paramtype = "light",
    is_ground_content = false,
    walkable = false,
    selection_box = {
        type = "fixed",
        fixed = { -0.2500, -0.5000, -0.2500, 0.2500, -0.1250, 0.2500 }
    },
    groups = { vessel = 1, bowl = 1, dig_immediate = 3, attached_node = 1 },
    sounds = default.node_sound_wood_defaults(),
})

if core.get_modpath("biometer") then
    core.register_alias_force("cooking:wooden_bowl", "biometer:bowl")
end
