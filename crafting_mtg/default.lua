-- craft slabs from tree trunks
craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = {"group:tree"},
    tool = {"group:axe"},
    output = {"group:slab 2"}
})

-- craft wood planks from slabs
craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = {"group:slab"},
    tool = {"group:axe"},
    output = {"group:wood 2"}
})

-- craft sticks from wood planks
craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = {"group:wood"},
    tool = {"group:axe"},
    output = {"group:stick 4"}
})

craftlib.register_replacement("group:vessel", {"vessel:glass_bottle", "vessel:drinking_glass", "vessel:steel_bottle"})
