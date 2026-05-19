metalworking = {
    path = core.get_modpath(core.get_current_modname()),
}

function nmnt.remove_material(mod, material, tools, ingot)
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
                    nmnt.register_sand_cast(recipe.items[1], ingot_name)
                end
            end
        end
    end
end

nmnt.remove_material("default", "wood", true, false)
nmnt.remove_material("default", "stone", true, false)
nmnt.remove_material("default", "steel", true, true)
nmnt.remove_material("default", "bronze", true, false)
nmnt.remove_material("default", "copper", false, true)
nmnt.remove_material("default", "gold", false, true)
nmnt.remove_material("default", "tin", false, true)
nmnt.remove_material("default", "mese", true, false)
nmnt.remove_material("default", "diamond", true, false)
if core.get_modpath("ethereal") then
    nmnt.remove_material("ethereal", "crystal", true, false)
end

dofile(metalworking.path .. "/tools.lua")
dofile(metalworking.path .. "/molds.lua")
