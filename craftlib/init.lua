craftlib = {
    path = core.get_modpath(core.get_current_modname()),
    registered_crafts = {}
}

dofile(craftlib.path .. "/api.lua")
dofile(craftlib.path .. "/crafts.lua")

core.register_on_mods_loaded(function()
    for name, def in pairs(core.registered_nodes) do
        if craftlib.registered_crafts[name] then
            core.override_item(name, {
                on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
                    local item = string.match(itemstack, "^([^ ]+)")
                    if clicker:get_player_control().sneak then
                        -- crafting activated
                        for _, craft in ipairs(craftlib.registered_crafts[name]) do
                            local item_matches = false
                            for _, input in ipairs(craft.input) do
                                if string.match(input, "^group:") then
                                    local group = string.match(input, "^group:(.+)")
                                    if core.registered_items[item] and core.registered_items[item].groups[group] then
                                        item_matches = true
                                    end
                                elseif string.match(input, item) then
                                    item_matches = true
                                end
                            end
                            if item_matches then
                                -- found matching craft, allow adding
                                return
                            end
                        end
                    end
                    return def.on_rightclick(pos, node, clicker, itemstack, pointed_thing)
                end,
                on_dig = function(pos, node, digger)

                end
            })
        else
            for group,_ in pairs(def.groups) do
                -- 
            end
        end
    end
end)