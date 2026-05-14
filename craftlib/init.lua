craftlib = {
    path = core.get_modpath(core.get_current_modname()),
    registered_crafts = {},
    bases = {},
    inputs = {},
    outputs = {},
    tools = {},
}

dofile(craftlib.path .. "/api.lua")
dofile(craftlib.path .. "/crafts.lua")

local organize_recipes = function(key)

end

core.register_on_mods_loaded(function()
    local groups = {
        base = {},
        input = {},
        tool = {},
        output = {}
    }
    local keys = { "base", "input", "tool", "output" }
    for i, recipe in ipairs(craftlib.registered_crafts) do
        for _, key in ipairs(keys) do
            if recipe[key] and #recipe[key] > 0 then
                for _, str in recipe[key] do
                    if string.match(str, "^group:") then
                        local group = string.match(str, "^group:([^ ]+)")
                        local in_groups_yet = false
                        for igroup, _ in pairs(groups[key]) do
                            if group == igroup then
                                in_groups_yet = true
                                groups[key][group][#groups[key][group]] = i
                                break
                            end
                        end
                        if in_groups_yet == false then
                            groups[key][group] = {i}
                        end
                    else
                        if craftlib[key..'s'][str] == nil then
                            craftlib[key..'s'][str] = {}
                        end
                    end
                    -- save the index from craftlib.registered_crafts
                    craftlib[key..'s'][str][#craftlib[key..'s'][str]] = i
                end
            end
        end
    end
    for name, def in pairs(core.registered_nodes) do
        for _,key in ipairs(keys) do
            for igroup, i in pairs(groups[key]) do
                for group, _ in pairs(def.groups) do
                    if group == igroup then
                        -- local recipe = craftlib.registered_crafts[i]
                        craftlib[key..'s'][name][#craftlib[key..'s'][name]] = i
                    end
                end
            end
        end
        if craftlib.registered_crafts[name] then
            local old_on_rightclick = def.on_rightclick
            local old_on_dig = def.on_dig
            core.override_item(name, {
                on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                    local item = string.match(itemstack, "^([^ ]+)")
                    if clicker:get_player_control().sneak and craftlib.bases(pos) then
                        -- crafting activated
                        craftlib.activate_crafting(pos, node, clicker, itemstack, pointed_thing)
                    end
                    if old_on_rightclick then
                        return old_on_rightclick(pos, node, clicker, itemstack, pointed_thing)
                    end
                end,
                on_dig = function(pos, node, digger)
                    if craftlib.is_crafting_activated(pos, node, digger) then
                    end
                    if old_on_dig then
                        return old_on_dig(pos, node, digger)
                    end
                end
            })
        else
            for group,_ in pairs(def.groups) do
                -- 
            end
        end
    end
end)