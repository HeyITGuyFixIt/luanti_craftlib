craftlib = {
    path = core.get_modpath(core.get_current_modname()),
    crafts = {}
}

dofile(craftlib.path .. "/api.lua")
dofile(craftlib.path .. "/crafts.lua")
