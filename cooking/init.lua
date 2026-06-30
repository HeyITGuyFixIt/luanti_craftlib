cooking = {
    path = core.get_modpath(core.get_current_modname()),
    recipes = {}
}

dofile(cooking.path .. "/utensils.lua")

cooking.register_recipe = function(def)
    for index, step in ipairs(def.steps) do
        craftlib.register(step)
        if not cooking.recipes[def.type] then
            cooking.recipes
        end
    end
end

-- Essential Foods
dofile(cooking.path .. "/food/water.lua")
dofile(cooking.path .. "/food/vinegar.lua")
dofile(cooking.path .. "/food/sausage.lua")
dofile(cooking.path .. "/food/cheese.lua")

-- Complex Foods
dofile(cooking.path .. "/food/bread.lua")
dofile(cooking.path .. "/food/pizza.lua")
if core.get_modpath("pie") then
    dofile(crafting_mods.path .. "/food/cakes.lua")
end
dofile(cooking.path .. "/cookbook.lua")
