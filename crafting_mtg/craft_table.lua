core.register_node("crafting_mtg:crafttable", {
    name = "Craft Table",
    tiles = { "craft_table_top.png", "default_wood.png", "craft_table_side.png",
        "craft_table_side.png", "craft_table_side.png", "craft_table_front.png" },
    paramtype2 = "facedir",
    groups = { choppy = 2, oddly_breakable_by_hand = 2 },
    legacy_facedir_simple = true,
    is_ground_content = false,
    sounds = default.node_sound_wood_defaults(),
})

craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = { "group:slab 2" },
    tool = { "group:axe" },
    output = { "crafting_mtg:crafttable" }
})

core.register_alias_force("crafting_mtg:crafttable", "xdecor:workbench")
core.register_alias_force("crafting_mtg:crafttable", "craft_table:simple")
