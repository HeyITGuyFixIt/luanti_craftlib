core.register_node("cooking:vinegar_source", {
    description = "Vinegar Source",
    drawtype = "liquid",
    waving = 3,
    tiles = {
        {
            name = "cooking_vinegar_source_animated.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
        {
            name = "cooking_vinegar_source_animated.png",
            backface_culling = true,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 2.0,
            },
        },
    },
    use_texture_alpha = "blend",
    paramtype = "light",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drop = "",
    drowning = 1,
    liquidtype = "source",
    liquid_alternative_flowing = "cooking:vinegar_flowing",
    liquid_alternative_source = "cooking:vinegar_source",
    liquid_viscosity = 1,
    post_effect_color = { a = 103, r = 168, g = 168, b = 56 },
    groups = { food_vinegar = 3, liquid = 3, cools_lava = 1 },
    sounds = default.node_sound_water_defaults(),
})

core.register_node("cooking:vinegar_flowing", {
    description = "Flowing Vinegar",
    drawtype = "flowingliquid",
    waving = 3,
    tiles = { "cooking_vinegar.png" },
    special_tiles = {
        {
            name = "cooking_vinegar_flowing_animated.png",
            backface_culling = false,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.5,
            },
        },
        {
            name = "cooking_vinegar_flowing_animated.png",
            backface_culling = true,
            animation = {
                type = "vertical_frames",
                aspect_w = 16,
                aspect_h = 16,
                length = 0.5,
            },
        },
    },
    use_texture_alpha = "blend",
    paramtype = "light",
    paramtype2 = "flowingliquid",
    walkable = false,
    pointable = false,
    diggable = false,
    buildable_to = true,
    is_ground_content = false,
    drop = "",
    drowning = 1,
    liquidtype = "flowing",
    liquid_alternative_flowing = "cooking:vinegar_flowing",
    liquid_alternative_source = "cooking:vinegar_source",
    liquid_viscosity = 1,
    post_effect_color = { a = 103, r = 168, g = 168, b = 56 },
    groups = {
        food_vinegar = 3,
        liquid = 3,
        not_in_creative_inventory = 1,
        cools_lava = 1
    },
    sounds = default.node_sound_water_defaults(),
})
bottles.register_filled_bottle({
    target = { "cooking:vinegar_source", "cooking:vinegar_flowing" },
    sound = "default_water_footstep",
    name = "vinegar_bottle",
    description = "Bottle of vinegar",
})
core.override_item("bottles:vinegar_bottle", {
    groups = { vessel = 1, dig_immediate = 3, attached_node = 1, food_vinegar = 1 }
})
if core.get_modpath('farming') and farming.redo and core.get_modpath('wine') then
    wine.add_item({ "farming:bottle_ethanol", "bottles:vinegar_bottle" })
end
