metalworking = {
    path = core.get_modpath(core.get_current_modname()),
}

dofile(metalworking.path .. "/tools.lua")
dofile(metalworking.path .. "/molds.lua")