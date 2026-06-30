crafting_mods = {
    path = core.get_modpath(core.get_current_modname()),
    mods = { "cement", "frame", "snowman" }
}
for _, mod in ipairs(crafting_mods.mods) do
    if core.get_modpath(mod) then
        dofile(crafting_mods.path .. "/".. mod ..".lua")
    end
end
