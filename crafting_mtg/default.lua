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

-- craft sticks from tree branches
craftlib.register_craft({
    type = "craft",
    base = crafting_mtg.tool_bases.axe,
    input = {"group:leaves"},
    tool = {""},
    output = {"group:stick"}
})

-- craft torch from stick and coal
craftlib.register_craft({
    type = "craft",
    base = {"group:node"},
    input = {"group:stick", "group:coal"},
    tool = {""},
    output = {"default:torch"}
})

craftlib.register_craft({
    type = "craft",
    base = {"crafting_mtg:crafttable"},
    input = {"group:leather", "default:paper 3", "group:string"},
    output = {"default:book"},
    tool = {""}
})

core.register_craftitem("crafting_mtg:paper_wet", {
    description = "Wet Papyrus Sheet",
    inventory_image = "default_paper.png", --needs to be collorized green
})

craftlib.register_craft({
    type = "craft",
    base = {"crafting_mtg:crafttable"},
    input = {"default:papyrus 2"},
    output = {"crafting_mtg:paper_wet"},
    tool = {"group:hammer"}
})

craftlib.register_replacement("group:vessel", {"vessel:glass_bottle", "vessel:drinking_glass", "vessel:steel_bottle"})
