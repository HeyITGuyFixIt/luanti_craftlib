metalworking = {
    path = core.get_modpath(core.get_current_modname()),
}

dofile(metalworking.path .. "/functions.lua")
dofile(metalworking.path .. "/molds.lua")
dofile(metalworking.path .. "/tools.lua")
