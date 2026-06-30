cooking = {
    path = core.get_modpath(core.get_current_modname()),
    recipes = {}
}

dofile(cooking.path .. "/utensils.lua")

cooking.register_recipe = function(def)
    -- def = { type = "", output = "", steps = {} }
    for index, step in ipairs(def.steps) do
        craftlib.register_craft(step)
    end
    if not cooking.recipes[def.type] then
        cooking.recipes[def.type] = {}
    end
    if type(def.output) == "string" then
        cooking.recipes[def.type][def.output] = def.steps
    else
        for _, output in ipairs(def.output) do
            cooking.recipes[def.type][output] = def.steps
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
