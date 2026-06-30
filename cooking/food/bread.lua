cooking.register_recipe({
    output = "farming:bread",
    type = "Baking",
    steps = {
        {
            type = "mix",
            base = { "cooking:mortar" },
            input = { "farming:wheat 4" },
            tool = "group:stick",
            output = { "farming:flour" }
        },
        {
            type = "mix",
            base = { "cooking:mixing_bowl" },
            input = {
                "group:food_flour",
                "group:food_sugar",
                "group:food_salt",
                "openion_yeast:bottle_of_yeast",
                "group:food_water"
            },
            output = { "cooking:bread_dough" }
        },
        {
            type = "cook",
            time = 15,
            base = { "default:furnace" },
            input = { "cooking:bread_dough" },
            output = { "farming:bread" }
        }
    }
})
