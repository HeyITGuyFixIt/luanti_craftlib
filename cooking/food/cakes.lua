local function register_cake_craft(name, input_groups, input_names)
    input_items = {}
    for key, value in pairs(input_groups) do
        if value then
            table.insert(input_items, 'group:food_'..key..' '..value)
        end
    end
    if input_names then
        for _, value in ipairs(input_names) do
            table.insert(input_items, value)
        end
    end
    core.clear_craft({ output = name })
    craftlib.register_craft({
        type = "mix",
        base = { "cooking:mixing_bowl" },
        input = input_items,
        tool = { "group:stick", "group:mixing_spoon" },
        output = { name }
    })
end
register_cake_craft("pie:pie_0", {
    sugar = 4,
    flour = 3,
    egg = 1,
    milk_glass = 1
})
register_cake_craft("pie:choc_0", {
    sugar = 2,
    cocoa = 2,
    flour = 3,
    egg = 1,
    milk_glass = 1
})
register_cake_craft("pie:scsk_0", {
    sugar = 2,
    strawberry = 2,
    flour = 3,
    egg = 1,
    milk_glass = 1
})
register_cake_craft("pie:coff_0", {
    flour = 3,
    salt = 1,
    milk_glass = 1,
    coffee = 1,
    vanilla = 1,
    butter = 2,
    sugar = 2,
    egg = 3,
})
register_cake_craft("pie:rvel_0", {
    sugar = 2,
    cocoa = 1,
    flour = 3,
    egg = 4,
    milk_glass = 1,
    cheese = 1,
    vinegar = 1,
    salt = 1,
    butter = 1,
    vanilla = 1
}, { "dye:red" })