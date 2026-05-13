local axe_bases = {"group:soil", "group:stone"}

craftlib.register_craft({
    type = "craft",
    base = axe_bases,
    input = {"group:tree"},
    tool = "group:axe",
    output = "group:slab 2"
})

craftlib.register_craft({
    base = axe_bases,
    input = {"group:slab"},
    tool = "group:axe",
    output = "group:wood 2"
})

craftlib.register_craft({
    base = axe_bases,
    input = {"group:wood"},
    tool = "group:axe",
    output = "group:stick 4"
})
