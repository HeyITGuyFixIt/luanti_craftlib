crafting_mtg = {
    path = core.get_modpath(core.get_current_modname()),
    tool_bases = {
        axe = {"group:soil", "group:stone", "group:tree", "group:wood"},
        hand = {"crafting_mtg:crafttable"}
    }
}

core.register_node("crafting_mtg:crafttable", {
    name = "Craft Table"
})

craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = {"group:slab 2"},
    tool = {"group:axe"},
    output = {"crafting_mtg:crafttable"}
})

dofile(crafting_mtg.path .. "/default.lua")
