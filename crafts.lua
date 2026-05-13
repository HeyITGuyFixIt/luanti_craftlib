local axe_surfaces = {"group:soil", "group:stone"}

craftlib.register_craft({
    surface = axe_surfaces,
    input = {"group:tree"},
    tool = "group:axe",
    output = "group:slab 2"
})

craftlib.register_craft({
    surface = axe_surfaces,
    input = {"group:slab"},
    tool = "group:axe",
    output = "group:wood 2"
})

craftlib.register_craft({
    surface = axe_surfaces,
    input = {"group:wood"},
    tool = "group:axe",
    output = "group:stick 4"
})
