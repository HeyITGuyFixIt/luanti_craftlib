cooking = {
    path = core.get_modpath(core.get_current_modname()),
}

dofile(cooking.path .. "/utensils.lua")
dofile(cooking.path .. "/ingredients.lua")
