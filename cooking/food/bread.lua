craftlib.register_craft({
    type = "mix",
    base = { "cooking:mortar" },
    input = { "farming:wheat 4" },
    tool = "group:stick",
    output = { "farming:flour" }
})
craftlib.register_craft({
    type = "mix",
    base = { "cooking:mixing_bowl" },
    input = {
        "group:food_flour",
        "group:food_sugar",
        "group:food_salt",
        "openion_yeast:bottle_of_yeast",
        "group:food_water"
    }
})