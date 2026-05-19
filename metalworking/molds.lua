craftlib.register_craft({
    type = "knap",
    base = {"group:slab"},
    tool = { "group:chisel", "group:axe" },
    pattern = {
        {1, 1, 1, 1, 1, 1, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 0, 0, 1, 1, 1},
        {1, 1, 1, 0, 0, 1, 1, 1},
        {1, 1, 0, 0, 0, 0, 1, 1},
        {1, 0, 0, 0, 0, 0, 0, 1},
        {1, 1, 1, 1, 1, 1, 1, 1}
    },
    output = { "metalworking:pattern_anvil" }
})

core.register_node("metalworking:pattern_anvil", {
    name = "Metal Anvil Pattern",
})
