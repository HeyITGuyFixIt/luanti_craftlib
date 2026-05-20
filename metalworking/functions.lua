function metalworking.remove_material(mod, material, tools, ingot)
    if tools then
        core.clear_craft({ output = mod .. ":axe_" .. material })
        core.clear_craft({ output = mod .. ":pick_" .. material })
        core.clear_craft({ output = mod .. ":shovel_" .. material })
        core.clear_craft({ output = mod .. ":sword_" .. material })
    end
    if ingot then
        local ingot_name = mod .. ":" .. material .. "_ingot"
        local recipes = core.get_all_craft_recipes(ingot_name)
        if recipes then
            for _, recipe in ipairs(recipes) do
                if recipe.method == "cooking" then
                    core.clear_craft({ type = "cooking", recipe = recipe.items[1] })
                    metalworking.register_sand_cast(recipe.items[1], ingot_name)
                end
            end
        end
    end
end

metalworking.register_sand_cast = function(name, ingot)
    craftlib.register_craft({
        type = "craft",
        base = {"group:sand"},
        input = { name }
        tool = { "group:hammer" },
        output = { "metalworking:sand_cast_"..string.match(name, ":(.+)") }
    })
end